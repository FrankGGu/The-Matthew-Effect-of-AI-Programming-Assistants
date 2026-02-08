impl Solution {
    pub fn add_operators(num: String, target: i32) -> Vec<String> {
        let mut result = Vec::new();
        let n = num.len();
        let nums: Vec<i64> = num.chars().map(|c| (c as u8 - b'0') as i64).collect();

        fn dfs(
            result: &mut Vec<String>,
            nums: &Vec<i64>,
            index: usize,
            current_expression: String,
            current_value: i64,
            prev_operand: i64,
            target: i32,
        ) {
            if index == nums.len() {
                if current_value == target as i64 {
                    result.push(current_expression);
                }
                return;
            }

            let mut current_num: i64 = 0;
            for i in index..nums.len() {
                if i > index && nums[index] == 0 {
                    break;
                }

                current_num = current_num * 10 + nums[i];

                if index == 0 {
                    dfs(
                        result,
                        nums,
                        i + 1,
                        current_num.to_string(),
                        current_num,
                        current_num,
                        target,
                    );
                } else {
                    dfs(
                        result,
                        nums,
                        i + 1,
                        format!("{}*{}", current_expression, current_num),
                        current_value - prev_operand + prev_operand * current_num,
                        prev_operand * current_num,
                        target,
                    );
                    dfs(
                        result,
                        nums,
                        i + 1,
                        format!("{}+{}", current_expression, current_num),
                        current_value + current_num,
                        current_num,
                        target,
                    );
                    dfs(
                        result,
                        nums,
                        i + 1,
                        format!("{}-{}", current_expression, current_num),
                        current_value - current_num,
                        -current_num,
                        target,
                    );
                }
            }
        }

        dfs(&mut result, &nums, 0, String::new(), 0, 0, target);
        result
    }
}