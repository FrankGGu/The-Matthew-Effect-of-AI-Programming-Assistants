impl Solution {
    pub fn min_cost_to_change(expression: String) -> i32 {
        fn calculate(tokens: &Vec<(char, i32)>) -> (i32, i32) {
            let mut nums: Vec<i32> = Vec::new();
            let mut ops: Vec<char> = Vec::new();

            for &(token_type, value) in tokens {
                if token_type == 'n' {
                    nums.push(value);
                } else if token_type == '(' {
                    ops.push(token_type);
                } else if token_type == ')' {
                    while ops.last() != Some(&'(') {
                        let op = ops.pop().unwrap();
                        let num2 = nums.pop().unwrap();
                        let num1 = nums.pop().unwrap();
                        nums.push(if op == '&' { num1 & num2 } else { num1 | num2 });
                    }
                    ops.pop();
                } else {
                    while ops.last() != None && ops.last() != Some(&'(') {
                        let op = ops.pop().unwrap();
                        let num2 = nums.pop().unwrap();
                        let num1 = nums.pop().unwrap();
                        nums.push(if op == '&' { num1 & num2 } else { num1 | num2 });
                    }
                    ops.push(token_type);
                }
            }

            while ops.len() > 0 {
                let op = ops.pop().unwrap();
                let num2 = nums.pop().unwrap();
                let num1 = nums.pop().unwrap();
                nums.push(if op == '&' { num1 & num2 } else { num1 | num2 });
            }

            (nums[0], 1)
        }

        fn dp(s: &String, i: &mut usize) -> (i32, i32) {
            let mut tokens: Vec<(char, i32)> = Vec::new();
            while *i < s.len() {
                let c = s.chars().nth(*i).unwrap();
                *i += 1;
                match c {
                    '(' => {
                        tokens.push(('(', 0));
                    }
                    ')' => {
                        tokens.push((')', 0));
                        break;
                    }
                    '&' | '|' => {
                        tokens.push((c, 0));
                    }
                    '0' | '1' => {
                        tokens.push(('n', c.to_digit(10).unwrap() as i32));
                    }
                    _ => {}
                }
            }

            let mut nums: Vec<(i32, i32)> = Vec::new();
            let mut ops: Vec<char> = Vec::new();

            let mut j = 0;
            while j < tokens.len() {
                let (token_type, value) = tokens[j];
                j += 1;
                if token_type == 'n' {
                    nums.push((if value == 0 { 1 } else { i32::MAX / 2 }, if value == 1 { 1 } else { i32::MAX / 2 }));
                } else if token_type == '(' {
                    let res = dp(s, i);
                    nums.push(res);
                } else if token_type == ')' {
                    while ops.last() != Some(&'(') {
                        let op = ops.pop().unwrap();
                        let (zero2, one2) = nums.pop().unwrap();
                        let (zero1, one1) = nums.pop().unwrap();
                        if op == '&' {
                            nums.push((zero1 + zero2, std::cmp::min(one1, one2) + 1));
                        } else {
                            nums.push((std::cmp::min(zero1, zero2) + 1, one1 + one2));
                        }
                    }
                    ops.pop();
                    break;
                } else {
                    while ops.last() != None && ops.last() != Some(&'(') {
                        let op = ops.pop().unwrap();
                        let (zero2, one2) = nums.pop().unwrap();
                        let (zero1, one1) = nums.pop().unwrap();
                        if op == '&' {
                            nums.push((zero1 + zero2, std::cmp::min(one1, one2) + 1));
                        } else {
                            nums.push((std::cmp::min(zero1, zero2) + 1, one1 + one2));
                        }
                    }
                    ops.push(token_type);
                }
            }

            while ops.len() > 0 {
                let op = ops.pop().unwrap();
                let (zero2, one2) = nums.pop().unwrap();
                let (zero1, one1) = nums.pop().unwrap();
                if op == '&' {
                    nums.push((zero1 + zero2, std::cmp::min(one1, one2) + 1));
                } else {
                    nums.push((std::cmp::min(zero1, zero2) + 1, one1 + one2));
                }
            }

            nums[0]
        }

        let mut i = 0;
        let (zero_cost, one_cost) = dp(&expression, &mut i);
        let tokens: Vec<(char, i32)> = expression.chars().map(|c| {
            if c.is_digit(10) {
                ('n', c.to_digit(10).unwrap() as i32)
            } else {
                (c, 0)
            }
        }).collect();
        let (result, _) = calculate(&tokens);

        if result == 0 {
            zero_cost
        } else {
            one_cost
        }
    }
}