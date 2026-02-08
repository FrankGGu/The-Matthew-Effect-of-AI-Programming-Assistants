impl Solution {
    pub fn find_error_nums(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut counts = vec![0; n + 1];

        for &num in &nums {
            counts[num as usize] += 1;
        }

        let mut duplicated = -1;
        let mut missing = -1;

        for i in 1..=n {
            if counts[i] == 2 {
                duplicated = i as i32;
            }
            if counts[i] == 0 {
                missing = i as i32;
            }
        }

        vec![duplicated, missing]
    }
}