impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        if nums.len() == 1 {
            return nums[0];
        }
        std::cmp::max(
            Self::rob_helper(&nums[0..nums.len() - 1]),
            Self::rob_helper(&nums[1..nums.len()])
        )
    }

    fn rob_helper(nums: &[i32]) -> i32 {
        let mut prev = 0;
        let mut curr = 0;
        for &num in nums {
            let temp = curr;
            curr = std::cmp::max(prev + num, curr);
            prev = temp;
        }
        curr
    }
}