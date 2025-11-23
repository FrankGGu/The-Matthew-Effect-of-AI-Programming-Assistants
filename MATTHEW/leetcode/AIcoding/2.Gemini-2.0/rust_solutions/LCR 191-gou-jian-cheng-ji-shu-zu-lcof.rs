impl Solution {
    pub fn count_ways(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut ans = 0;
        if nums[0] > 0 {
            ans += 1;
        }
        for i in 0..n {
            if i == n - 1 {
                if nums[i] < (i + 1) as i32 {
                    ans += 1;
                }
            } else {
                if nums[i] < (i + 1) as i32 && nums[i + 1] > (i + 1) as i32 {
                    ans += 1;
                }
            }
        }
        ans
    }
}