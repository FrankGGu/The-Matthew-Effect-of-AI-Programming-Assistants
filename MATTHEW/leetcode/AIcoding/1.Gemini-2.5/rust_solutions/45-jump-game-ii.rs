impl Solution {
    pub fn jump(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut jumps = 0;
        let mut current_reach = 0;
        let mut farthest_reach = 0;

        for i in 0..n - 1 {
            farthest_reach = farthest_reach.max(i as i32 + nums[i]);

            if i as i32 == current_reach {
                jumps += 1;
                current_reach = farthest_reach;
                if current_reach >= (n - 1) as i32 {
                    break;
                }
            }
        }
        jumps
    }
}