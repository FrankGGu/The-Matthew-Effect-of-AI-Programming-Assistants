impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        if nums.len() == 1 {
            return nums[0];
        }

        let n = nums.len();
        let res1 = Self::rob_linear(&nums[0..n - 1]);
        let res2 = Self::rob_linear(&nums[1..n]);

        res1.max(res2)
    }

    fn rob_linear(nums: &[i32]) -> i32 {
        let mut prev2 = 0;
        let mut prev1 = 0;

        for &num in nums {
            let current = prev1.max(prev2 + num);
            prev2 = prev1;
            prev1 = current;
        }

        prev1
    }
}