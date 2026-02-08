impl Solution {
    pub fn total_steps(nums: Vec<i32>) -> i32 {
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut res = 0;

        for num in nums {
            let mut max_t = 0;
            while !stack.is_empty() && stack.last().unwrap().0 <= num {
                max_t = max_t.max(stack.pop().unwrap().1);
            }
            let steps = if stack.is_empty() { 0 } else { max_t + 1 };
            res = res.max(steps);
            stack.push((num, steps));
        }

        res
    }
}