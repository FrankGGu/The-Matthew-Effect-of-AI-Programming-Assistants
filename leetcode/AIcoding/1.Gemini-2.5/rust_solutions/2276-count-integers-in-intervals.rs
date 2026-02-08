use std::collections::BTreeMap;

struct Intervals {
    map: BTreeMap<i32, i32>, // Stores intervals as (start -> end)
    count: i64,              // Total number of integers covered by all intervals
}

impl Intervals {
    fn new() -> Self {
        Intervals {
            map: BTreeMap::new(),
            count: 0,
        }
    }

    fn add(&mut self, left: i32, right: i32) {
        let mut current_left = left;
        let mut current_right = right;
        let mut total_removed_length: i64 = 0;
        let mut keys_to_remove = Vec::new();

        // Step 1: Adjust `current_left` based on any overlapping interval to its left.
        // Find the largest key `s_prev` such that `s_prev < left`.
        // If such an interval `[s_prev, e_prev]` exists and `e_prev >= left`,
        // it means `[s_prev, e_prev]` overlaps or touches the new interval `[left, right]`.
        // In this case, the new merged interval must start at `s_prev`.
        if let Some((&s_prev, &e_prev)) = self.map.range(..left).rev().next() {
            if e_prev >= left {
                current_left = s_prev;
            }
        }

        // Step 2: Iterate through intervals starting from `current_left` (adjusted)
        // and collect all overlapping intervals.
        // The `iter` captures the state of the map at this point.
        // `current_right` will dynamically expand as we merge intervals.
        let mut iter = self.map.range(current_left..);
        let mut temp_overlapping_intervals_data = Vec::new();

        // Collect all intervals that start from `current_left` and potentially overlap with
        // `[current_left, current_right]` (where `current_right` is dynamically updated).
        // The loop condition `s <= current_right` is crucial and uses the *dynamically updated* `current_right`.
        while let Some((&s, &e)) = iter.next() {
            if s <= current_right {
                // This interval `[s, e]` starts within or before the current merged interval's right boundary.
                // It must overlap because `s >= current_left` and `current_left` is the true start.
                temp_overlapping_intervals_data.push((s, e));
                current_right = current_right.max(e); // Expand `current_right`
            } else {
                // This interval `[s, e]` starts strictly after `current_right`.
                // Since intervals are sorted by start, no further intervals will overlap.
                break;
            }
        }

        // Step 3: Process the collected overlapping intervals.
        // Calculate the total length of intervals to be removed and collect their start keys.
        for (s, e) in temp_overlapping_intervals_data {
            total_removed_length += (e - s + 1) as i64;
            keys_to_remove.push(s);
        }

        // Step 4: Remove old intervals from the map.
        for key in keys_to_remove {
            self.map.remove(&key);
        }

        // Step 5: Insert the new merged interval.
        self.map.insert(current_left, current_right);

        // Step 6: Update the total count of integers.
        self.count -= total_removed_length;
        self.count += (current_right - current_left + 1) as i64;
    }

    fn count(&self) -> i32 {
        self.count as i32
    }
}