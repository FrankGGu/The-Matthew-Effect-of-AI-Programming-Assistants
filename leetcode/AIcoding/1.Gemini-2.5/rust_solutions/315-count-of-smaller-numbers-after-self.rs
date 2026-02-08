struct FenwickTree {
    tree: Vec<i32>,
    size: usize,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1], // 1-indexed
            size,
        }
    }

    // Add `val` to element at `idx` (0-indexed input, converted to 1-indexed internally)
    fn update(&mut self, mut idx: usize, val: i32) {
        idx += 1; // Convert to 1-indexed
        while idx <= self.size {
            self.tree[idx] += val;
            idx += idx & (!idx + 1); // Equivalent to idx += idx & (-idx) for 2's complement
        }
    }

    // Get sum of elements from 0 to `idx` (0-indexed input, converted to 1-indexed internally)
    fn query(&self, mut idx: usize) -> i32 {
        if idx == usize::MAX { // Handle case where we query for values smaller than the minimum possible
            return 0;
        }
        idx += 1; // Convert to 1-indexed
        let mut sum = 0;
        while idx > 0 {
            sum += self.tree[idx];
            idx -= idx & (!idx + 1); // Equivalent to idx -= idx & (-idx) for 2's complement
        }
        sum
    }
}

impl Solution {
    pub fn count_smaller(nums: Vec<i32>) -> Vec<i32> {
        if nums.is_empty() {
            return vec![];
        }

        // Constraints: -10^4 <= nums[i] <= 10^4
        // Shift values to be non-negative for Fenwick Tree
        // Smallest value: -10000, maps to 0
        // Largest value: 10000, maps to 20000
        let min_val = -10000;
        let offset = -min_val as usize; // 10000
        let bit_size = (10000 - min_val + 1) as usize; // Range of values: 20001

        let mut ft = FenwickTree::new(bit_size);
        let mut counts = vec![0; nums.len()];

        // Iterate from right to left
        for i in (0..nums.len()).rev() {
            let val = nums[i];
            let mapped_val = (val + offset as i32) as usize; // 0-indexed mapped value

            // Query for count of numbers strictly smaller than current val
            // This means querying for sum up to mapped_val - 1
            counts[i] = ft.query(mapped_val.wrapping_sub(1)); // Use wrapping_sub to handle 0 - 1 gracefully

            // Add current val to Fenwick tree
            ft.update(mapped_val, 1);
        }

        counts
    }
}