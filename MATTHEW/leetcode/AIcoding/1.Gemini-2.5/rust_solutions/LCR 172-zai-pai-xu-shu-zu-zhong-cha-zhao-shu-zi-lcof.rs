impl Solution {
    pub fn count_target_scores(nums: Vec<i32>, target: i32) -> i32 {
        let find_lower_bound = |arr: &[i32], val: i32| -> usize {
            let mut low = 0;
            let mut high = arr.len();
            while low < high {
                let mid = low + (high - low) / 2;
                if arr[mid] < val {
                    low = mid + 1;
                } else {
                    high = mid;
                }
            }
            low
        };

        let first_occurrence_idx = find_lower_bound(&nums, target);
        let first_occurrence_of_next_val_idx = find_lower_bound(&nums, target + 1);

        (first_occurrence_of_next_val_idx - first_occurrence_idx) as i32
    }
}