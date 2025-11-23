impl Solution {
    pub fn total_steps(nums: Vec<i32>) -> i32 {
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut res = 0;

        for num in nums {
            let mut steps = 0;
            while !stack.is_empty() && stack.last().unwrap().0 <= num {
                steps = steps.max(stack.pop().unwrap().1);
            }
            if !stack.is_empty() {
                steps += 1;
            } else {
                steps = 0;
            }
            res = res.max(steps);
            stack.push((num, steps));
        }

        res
    }
}