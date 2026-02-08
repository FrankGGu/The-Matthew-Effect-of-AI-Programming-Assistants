impl Solution {
    pub fn maximize_the_potential(nums: Vec<i32>, k: i32) -> i32 {
        let mut cnt = 0;
        let mut nums = nums.clone();
        nums.sort_unstable();

        for &num in nums.iter().rev() {
            if num >= k {
                cnt += 1;
            } else {
                break;
            }
        }

        cnt
    }
}