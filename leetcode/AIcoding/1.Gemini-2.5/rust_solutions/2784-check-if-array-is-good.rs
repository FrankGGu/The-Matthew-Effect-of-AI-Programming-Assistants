impl Solution {
    pub fn is_good(mut nums: Vec<i32>) -> bool {
        let n = nums.len();

        if n == 1 {
            return false;
        }

        nums.sort_unstable();

        for i in 0..n - 2 {
            if nums[i] != (i + 1) as i32 {
                return false;
            }
        }

        if nums[n - 2] != (n - 1) as i32 {
            return false;
        }
        if nums[n - 1] != (n - 1) as i32 {
            return false;
        }

        true
    }
}