impl Solution {
    pub fn moves_to_make_zigzag(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut cost = vec![0, 0];

        for i in 0..n {
            if i % 2 == 0 {
                if i > 0 && nums[i] >= nums[i - 1] {
                    cost[0] += nums[i] - nums[i - 1] + 1;
                }
                if i < n - 1 && nums[i] >= nums[i + 1] {
                    cost[0] += nums[i] - nums[i + 1] + 1;
                }
            } else {
                if i > 0 && nums[i] >= nums[i - 1] {
                    cost[1] += nums[i] - nums[i - 1] + 1;
                }
                if i < n - 1 && nums[i] >= nums[i + 1] {
                    cost[1] += nums[i] - nums[i + 1] + 1;
                }
            }
        }

        cost.into_iter().min().unwrap()
    }
}