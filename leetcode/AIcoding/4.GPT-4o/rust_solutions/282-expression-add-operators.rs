impl Solution {
    pub fn add_operators(num: String, target: i32) -> Vec<String> {
        let mut result = Vec::new();
        let n = num.len();
        let mut path = String::new();

        fn backtrack(num: &str, target: i32, index: usize, prev_operand: i64, current_value: i64, path: &mut String, result: &mut Vec<String>) {
            if index == num.len() {
                if current_value == target {
                    result.push(path.clone());
                }
                return;
            }
            for i in index..num.len() {
                if i != index && num.as_bytes()[index] == b'0' {
                    break;
                }
                let curr_str = &num[index..=i];
                let curr_num = curr_str.parse::<i64>().unwrap();
                let length = path.len();

                if index == 0 {
                    path.push_str(curr_str);
                    backtrack(num, target, i + 1, curr_num, curr_num, path, result);
                    path.truncate(length);
                } else {
                    path.push('+');
                    path.push_str(curr_str);
                    backtrack(num, target, i + 1, curr_num, current_value + curr_num, path, result);
                    path.truncate(length);

                    path.push('-');
                    path.push_str(curr_str);
                    backtrack(num, target, i + 1, -curr_num, current_value - curr_num, path, result);
                    path.truncate(length);

                    path.push('*');
                    path.push_str(curr_str);
                    backtrack(num, target, i + 1, prev_operand * curr_num, current_value - prev_operand + (prev_operand * curr_num), path, result);
                    path.truncate(length);
                }
            }
        }

        backtrack(&num, target, 0, 0, 0, &mut path, &mut result);
        result
    }
}