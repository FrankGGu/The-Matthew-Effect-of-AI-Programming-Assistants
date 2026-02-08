impl Solution {
    pub fn check(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut k = 0;
        for i in 0..n {
            if nums[i] > nums[(i + 1) % n] {
                k += 1;
            }
        }
        k <= 1
    }
}