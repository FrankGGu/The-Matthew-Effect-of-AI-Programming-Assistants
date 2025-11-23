impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        if nums.len() == 1 {
            return nums[0];
        }

        fn rob_linear(houses: &[i32]) -> i32 {
            let mut rob1 = 0;
            let mut rob2 = 0;

            for &n in houses {
                let temp = std::cmp::max(rob2, rob1 + n);
                rob1 = rob2;
                rob2 = temp;
            }
            rob2
        }

        let n = nums.len();
        let res1 = rob_linear(&nums[0..n - 1]);
        let res2 = rob_linear(&nums[1..n]);

        std::cmp::max(res1, res2)
    }
}