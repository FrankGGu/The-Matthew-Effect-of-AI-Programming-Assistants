impl Solution {
    pub fn find_error_nums(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut seen = vec![false; n + 1];
        let mut repeated = 0;
        let mut missing = 0;

        for &num in &nums {
            if seen[num as usize] {
                repeated = num;
            } else {
                seen[num as usize] = true;
            }
        }

        for i in 1..=n {
            if !seen[i] {
                missing = i as i32;
                break;
            }
        }

        vec![repeated, missing]
    }
}