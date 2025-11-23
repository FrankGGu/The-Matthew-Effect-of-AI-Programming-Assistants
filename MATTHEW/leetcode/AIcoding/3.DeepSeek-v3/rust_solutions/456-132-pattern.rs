impl Solution {
    pub fn find132pattern(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n < 3 {
            return false;
        }
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut min_i = nums[0];

        for j in 1..n {
            while !stack.is_empty() && nums[j] >= stack.last().unwrap().0 {
                stack.pop();
            }
            if !stack.is_empty() && nums[j] > stack.last().unwrap().1 {
                return true;
            }
            stack.push((nums[j], min_i));
            min_i = min_i.min(nums[j]);
        }
        false
    }
}