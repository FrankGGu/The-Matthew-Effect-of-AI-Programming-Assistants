impl Solution {
    pub fn score_of_students(s: String, answers: Vec<i32>) -> i32 {
        let n = s.len();
        let nums = s.chars().step_by(2).map(|c| c.to_digit(10).unwrap() as i32).collect::<Vec<_>>();
        let ops = s.chars().skip(1).step_by(2).collect::<Vec<_>>();

        let correct_ans = Solution::calculate(&nums, &ops);

        let mut dp = vec![std::collections::HashSet::new(); n / 2 + 1];
        dp[0].insert(nums[0]);

        for i in 0..ops.len() {
            let num_idx = i + 1;
            let op = ops[i];

            let mut new_dp = vec![std::collections::HashSet::new(); n / 2 + 1];

            for j in 0..=i {
                for &val1 in &dp[j] {
                    for &val2 in &dp[num_idx - j -1] {
                        let res = match op {
                            '+' => val1 + nums[num_idx],
                            '*' => val1 * nums[num_idx],
                            _ => 0,
                        };
                        if res <= 1000 {
                            new_dp[num_idx].insert(res);
                        }
                    }
                }
            }
            dp[num_idx] = new_dp[num_idx].clone();
        }

        let possible_answers = dp[n / 2].clone();

        let mut score = 0;
        for &answer in &answers {
            if answer == correct_ans {
                score += 5;
            } else if possible_answers.contains(&answer) {
                score += 2;
            }
        }

        score
    }

    fn calculate(nums: &Vec<i32>, ops: &Vec<char>) -> i32 {
        let mut nums_stack = Vec::new();
        let mut ops_stack = Vec::new();

        for i in 0..nums.len() {
            nums_stack.push(nums[i]);
            if i < ops.len() {
                while !ops_stack.is_empty() && Solution::precedence(ops[i]) <= Solution::precedence(*ops_stack.last().unwrap()) {
                    Solution::evaluate(&mut nums_stack, &mut ops_stack);
                }
                ops_stack.push(ops[i]);
            }
        }

        while !ops_stack.is_empty() {
            Solution::evaluate(&mut nums_stack, &mut ops_stack);
        }

        nums_stack[0]
    }

    fn precedence(op: char) -> i32 {
        match op {
            '+' => 1,
            '*' => 2,
            _ => 0,
        }
    }

    fn evaluate(nums_stack: &mut Vec<i32>, ops_stack: &mut Vec<char>) {
        let num2 = nums_stack.pop().unwrap();
        let num1 = nums_stack.pop().unwrap();
        let op = ops_stack.pop().unwrap();

        let res = match op {
            '+' => num1 + num2,
            '*' => num1 * num2,
            _ => 0,
        };

        nums_stack.push(res);
    }
}