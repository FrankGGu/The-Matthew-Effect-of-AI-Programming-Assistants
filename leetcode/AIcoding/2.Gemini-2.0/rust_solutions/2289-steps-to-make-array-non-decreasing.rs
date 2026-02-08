impl Solution {
    pub fn total_steps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut ans = 0;

        for &num in nums.iter().rev() {
            let mut steps = 0;
            while !stack.is_empty() && num > stack.last().unwrap().0 {
                steps = steps.max(stack.pop().unwrap().1 + 1);
            }
            ans = ans.max(steps);
            stack.push((num, steps));
        }

        ans
    }
}