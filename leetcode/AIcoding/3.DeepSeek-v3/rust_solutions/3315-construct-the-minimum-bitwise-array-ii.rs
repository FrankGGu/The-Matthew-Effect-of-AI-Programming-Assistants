impl Solution {
    pub fn construct_minimum_bitwise_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut res = vec![0; n];
        let mut stack = Vec::new();

        for i in (0..n).rev() {
            while !stack.is_empty() && nums[i] < nums[*stack.last().unwrap()] {
                stack.pop();
            }
            if stack.is_empty() {
                res[i] = nums[i];
            } else {
                res[i] = nums[i] & res[*stack.last().unwrap()];
            }
            stack.push(i);
        }
        res
    }
}