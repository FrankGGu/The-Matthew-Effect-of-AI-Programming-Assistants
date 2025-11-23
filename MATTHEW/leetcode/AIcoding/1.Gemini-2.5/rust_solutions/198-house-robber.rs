impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }

        let mut prev2 = nums[0];
        let mut prev1 = std::cmp::max(nums[0], nums[1]);

        for i in 2..n {
            let current = std::cmp::max(prev1, prev2 + nums[i]);
            prev2 = prev1;
            prev1 = current;
        }

        prev1
    }
}