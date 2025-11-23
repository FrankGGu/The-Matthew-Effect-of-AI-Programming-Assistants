impl Solution {
    pub fn max_distance(arrays: Vec<Vec<i32>>) -> i32 {
        let mut max_dist = 0;

        // Initialize min_val and max_val with the first array's min and max.
        // Since each array is sorted in ascending order, the minimum element
        // is at index 0 and the maximum element is at the last index.
        // Problem constraints guarantee m >= 2 and arrays[i].length >= 1,
        // so arrays[0] and its elements are safe to access.
        let mut min_val = arrays[0][0];
        let mut max_val = arrays[0][arrays[0].len() - 1];

        // Iterate through the rest of the arrays starting from the second one.
        for i in 1..arrays.len() {
            let current_arr = &arrays[i];
            let current_min = current_arr[0];
            let current_max = current_arr[current_arr.len() - 1];

            // Calculate potential maximum distances:
            // 1. The absolute difference between the current array's maximum
            //    and the minimum value seen so far from previous arrays.
            // 2. The absolute difference between the current array's minimum
            //    and the maximum value seen so far from previous arrays.
            // These two scenarios cover all possibilities for picking one
            // value from a previous array and one from the current array.
            max_dist = max_dist.max((max_val - current_min).abs());
            max_dist = max_dist.max((current_max - min_val).abs());

            // Update the overall minimum and maximum values encountered so far.
            min_val = min_val.min(current_min);
            max_val = max_val.max(current_max);
        }

        max_dist
    }
}