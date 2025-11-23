use std::collections::BTreeSet;

struct MedianTracker {
    left_half: BTreeSet<i64>,  // Elements less than or equal to the median (max-heap behavior)
    right_half: BTreeSet<i64>, // Elements greater than the median (min-heap behavior)
    left_sum: i64,
    right_sum: i64,
}

impl MedianTracker {
    fn new() -> Self {
        MedianTracker {
            left_half: BTreeSet::new(),
            right_half: BTreeSet::new(),
            left_sum: 0,
            right_sum: 0,
        }
    }

    // Balances the two sets to maintain the median property:
    // left_half.len() == right_half.len() or left_half.len() == right_half.len() + 1
    fn balance(&mut self) {
        while self.left_half.len() > self.right_half.len() + 1 {
            let val = *self.left_half.iter().rev().next().unwrap(); // Largest in left_half
            self.left_half.remove(&val);
            self.left_sum -= val;
            self.right_half.insert(val);
            self.right_sum += val;
        }
        while self.right_half.len() > self.left_half.len() {
            let val = *self.right_half.iter().next().unwrap(); // Smallest in right_half
            self.right_half.remove(&val);
            self.right_sum -= val;
            self.left_half.insert(val);
            self.left_sum += val;
        }
    }

    // Adds a value to the tracker and rebalances
    fn add(&mut self, val: i64) {
        if self.left_half.is_empty() || val <= *self.left_half.iter().rev().next().unwrap() {
            self.left_half.insert(val);
            self.left_sum += val;
        } else {
            self.right_half.insert(val);
            self.right_sum += val;
        }
        self.balance();
    }

    // Removes a value from the tracker and rebalances
    fn remove(&mut self, val: i64) {
        // Determine which half the value is in and remove it
        if self.left_half.contains(&val) {
            self.left_half.remove(&val);
            self.left_sum -= val;
        } else if self.right_half.contains(&val) {
            self.right_half.remove(&val);
            self.right_sum -= val;
        }
        // After removal, rebalance to ensure the median property is restored
        self.balance();
    }

    // Calculates the sum of absolute differences from the median for all elements
    fn get_cost(&self) -> i64 {
        if self.left_half.is_empty() {
            return 0;
        }
        let median = *self.left_half.iter().rev().next().unwrap();
        // Cost = Sum(|x - median|)
        // For x in left_half: median - x
        // For x in right_half: x - median
        (median * self.left_half.len() as i64 - self.left_sum) + (self.right_sum - median * self.right_half.len() as i64)
    }
}

impl Solution {
    pub fn min_moves(nums: Vec<i32>, k: i32) -> i64 {
        if k == 0 {
            return 0;
        }

        let mut pos: Vec<i64> = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                pos.push(i as i64);
            }
        }

        let m = pos.len() as i32; // Number of initial ones

        // If there are fewer initial ones than k, we must create (k - m) new ones.
        // This costs (k - m). These new ones can be placed optimally (0 movement cost).
        // The problem then reduces to moving the 'm' existing ones to form a contiguous block of length 'm'.
        // The total k ones will form a contiguous block of length k, with the 'm' existing ones occupying 'm' slots
        // and 'k-m' new ones occupying the remaining slots.
        // The movement cost is only for the 'm' existing ones.
        let (base_cost, window_size) = if m < k {
            ((k - m) as i64, m as usize)
        } else {
            (0, k as usize)
        };

        if window_size == 0 { // This case handles m=0 and k>0 (base_cost = k, window_size = 0)
            return base_cost;
        }

        // Transform indices: for a window of k ones at pos[i], pos[i+1], ..., pos[i+k-1],
        // we want to move them to j, j+1, ..., j+k-1.
        // The cost is sum(|pos[i+x] - (j+x)|) for x from 0 to k-1.
        // This can be rewritten as sum(|(pos[i+x] - x) - j|).
        // Let q_y = pos[y] - y. We need to find j that minimizes sum(|q_y - j|).
        // This j is the median of q_y for the window.
        // So we need to calculate min(sum(|q_y - median(q_y)|)) over all windows of size `window_size`.

        let mut shifted_indices: Vec<i64> = Vec::with_capacity(m as usize);
        for i in 0..m as usize {
            shifted_indices.push(pos[i] - i as i64);
        }

        let mut median_tracker = MedianTracker::new();
        // Initialize for the first window
        for i in 0..window_size {
            median_tracker.add(shifted_indices[i]);
        }
        let mut min_movement_cost = median_tracker.get_cost();

        // Slide the window
        for i in 1..(m as usize - window_size + 1) {
            median_tracker.remove(shifted_indices[i - 1]);
            median_tracker.add(shifted_indices[i + window_size - 1]);
            min_movement_cost = min_movement_cost.min(median_tracker.get_cost());
        }

        base_cost + min_movement_cost
    }
}