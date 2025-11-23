use std::collections::HashSet;

impl Solution {
    pub fn score_of_students(expression: String, answers: Vec<i32>) -> i32 {
        let (nums, ops) = Self::parse_expression(&expression);
        let n = nums.len();

        // dp[i][j] stores all possible results for sub-expression nums[i..j]
        // where i is the starting index of numbers and j is the ending index.
        let mut dp: Vec<Vec<HashSet<i32>>> = vec![vec![HashSet::new(); n]; n];

        // Base case: sub-expressions of length 1 (single number)
        for i in 0..n {
            dp[i][i].insert(nums[i]);
        }

        // Fill DP table for lengths from 2 to n
        for len in 2..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;
                // k is the index of the operator that splits the expression
                // nums[i..k] op[k] nums[k+1..j]
                for k in i..j {
                    let op = ops[k];
                    for &val1 in &dp[i][k] {
                        for &val2 in &dp[k + 1][j] {
                            let res = match op {
                                '+' => val1 + val2,
                                '*' => val1 * val2,
                                _ => unreachable!(), // Expression is guaranteed to be valid
                            };
                            // Only consider results that do not exceed 1000
                            if res <= 1000 {
                                dp[i][j].insert(res);
                            }
                        }
                    }
                }
            }
        }

        let all_possible_results = &dp[0][n - 1];
        let correct_answer = Self::calculate_standard_answer(&nums, &ops);

        let mut total_score = 0;
        for ans in answers {
            if ans == correct_answer {
                total_score += 5;
            } else if all_possible_results.contains(&ans) {
                total_score += 2;
            }
            // Otherwise, 0 points are added, which is the default.
        }

        total_score
    }

    // Parses the expression string into a vector of numbers and a vector of operators.
    fn parse_expression(expression: &str) -> (Vec<i32>, Vec<char>) {
        let mut nums = Vec::new();
        let mut ops = Vec::new();
        let mut current_num_str = String::new();

        for c in expression.chars() {
            if c.is_ascii_digit() {
                current_num_str.push(c);
            } else {
                nums.push(current_num_str.parse().unwrap());
                current_num_str.clear();
                ops.push(c);
            }
        }
        // Add the last number after the loop finishes
        nums.push(current_num_str.parse().unwrap());

        (nums, ops)
    }

    // Calculates the standard answer respecting operator precedence (* before +).
    fn calculate_standard_answer(nums: &[i32], ops: &[char]) -> i32 {
        let mut temp_nums: Vec<i32> = Vec::new();
        let mut temp_ops: Vec<char> = Vec::new();

        // First pass: handle multiplications
        temp_nums.push(nums[0]); // Push the first number

        for i in 0..ops.len() {
            if ops[i] == '*' {
                // If current operator is '*', pop the last number, multiply, and push result
                let last_num = temp_nums.pop().unwrap();
                temp_nums.push(last_num * nums[i + 1]);
            } else { // ops[i] == '+'
                // If current operator is '+', just push the next number and the operator
                temp_nums.push(nums[i + 1]);
                temp_ops.push('+');
            }
        }

        // Second pass: handle additions
        let mut result = temp_nums[0];
        for i in 0..temp_ops.len() {
            result += temp_nums[i + 1];
        }

        result
    }
}