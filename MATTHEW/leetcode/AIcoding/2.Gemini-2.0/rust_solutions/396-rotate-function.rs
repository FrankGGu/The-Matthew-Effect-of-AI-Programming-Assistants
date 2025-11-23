impl Solution {
    pub fn max_rotate_function(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let sum: i32 = nums.iter().sum();
        let mut f = 0;
        for i in 0..n {
            f += i as i32 * nums[i];
        }
        let mut max_f = f;
        for i in (1..n).rev() {
            f = f + sum - n as i32 * nums[i];
            max_f = max_f.max(f);
        }
        max_f
    }
}