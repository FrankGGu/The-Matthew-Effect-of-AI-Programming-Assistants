impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 { return 0; }
        if n == 1 { return nums[0]; }

        fn rob_linear(nums: &[i32]) -> i32 {
            let mut prev1 = 0;
            let mut prev2 = 0;
            for &num in nums {
                let temp = prev1;
                prev1 = prev2.max(prev1 + num);
                prev2 = temp;
            }
            prev1
        }

        rob_linear(&nums[0..n-1]).max(rob_linear(&nums[1..n]))
    }
}