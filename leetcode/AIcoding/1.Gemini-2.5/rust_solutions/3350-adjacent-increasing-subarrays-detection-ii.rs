struct Solution;

impl Solution {
    pub fn adjacent_increasing_subarrays_detection_ii(nums: Vec<i32>) -> bool {
        let n = nums.len();

        if n < 2 {
            return false;
        }

        fn is_strictly_increasing(slice: &[i32]) -> bool {
            if slice.len() <= 1 {
                return true;
            }
            for i in 0..slice.len() - 1 {
                if slice[i] >= slice[i + 1] {
                    return false;
                }
            }
            true
        }

        for i in 0..n - 1 {
            let first_subarray = &nums[0..=i];
            let second_subarray = &nums[i + 1..];

            if is_strictly_increasing(first_subarray) && is_strictly_increasing(second_subarray) {
                return true;
            }
        }

        false
    }
}