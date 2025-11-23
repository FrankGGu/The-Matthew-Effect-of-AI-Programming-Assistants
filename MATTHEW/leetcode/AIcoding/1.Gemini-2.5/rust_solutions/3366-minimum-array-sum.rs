struct Solution;

impl Solution {
    pub fn min_array_sum(mut nums: Vec<i32>) -> i64 {
        nums.sort_unstable();

        let mut current_sum: i64 = 0;
        let mut expected_next_unique: i32 = 0;

        for num in nums {
            let actual_val_for_num = num.max(expected_next_unique);
            current_sum += actual_val_for_num as i64;
            expected_next_unique = actual_val_for_num + 1;
        }

        current_sum
    }
}