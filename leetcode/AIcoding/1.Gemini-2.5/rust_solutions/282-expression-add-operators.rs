struct Solution;

impl Solution {
    pub fn add_operators(num: String, target: i64) -> Vec<String> {
        let mut results = Vec::new();
        if num.is_empty() {
            return results;
        }

        let num_chars: Vec<char> = num.chars().collect();

        // Helper function for DFS (backtracking)
        // index: current starting position in num_chars
        // current_val: the value of the expression evaluated so far
        // last_operand: the value of the last number/operand added or subtracted. Crucial for multiplication.
        // path: the string representation of the expression built so far
        fn backtrack(
            index: usize,
            current_val: i64,
            last_operand: i64,
            path: &mut String,
            num_chars: &[char],
            target: i64,
            results: &mut Vec<String>,
        ) {
            if index == num_chars.len() {
                if current_val == target {
                    results.push(path.clone());
                }
                return;
            }

            let path_len_before_append = path.len();
            let mut current_num: i64 = 0;

            for i in index..num_chars.len() {
                // Handle leading zeros: "05" is not a valid number, but "0" is.
                // If the current number starts with '0' and has more than one digit, it's invalid.
                if i > index && num_chars[index] == '0' {
                    break;
                }

                current_num = current_num * 10 + (num_chars[i] as i64 - '0' as i64);

                // If it's the first number in the expression
                if index == 0 {
                    path.push_str(&current_num.to_string());
                    backtrack(
                        i + 1,
                        current_num,
                        current_num,
                        path,
                        num_chars,
                        target,
                        results,
                    );
                    path.truncate(path_len_before_append); // Backtrack path
                } else {
                    // Try adding '+'
                    path.push('+');
                    path.push_str(&current_num.to_string());
                    backtrack(
                        i + 1,
                        current_val + current_num,
                        current_num,
                        path,
                        num_chars,
                        target,
                        results,
                    );
                    path.truncate(path_len_before_append); // Backtrack path

                    // Try adding '-'
                    path.push('-');
                    path.push_str(&current_num.to_string());
                    backtrack(
                        i + 1,
                        current_val - current_num,
                        -current_num, // last_operand becomes negative for subtraction
                        path,
                        num_chars,
                        target,
                        results,
                    );
                    path.truncate(path_len_before_append); // Backtrack path

                    // Try adding '*'
                    // For multiplication, we need to undo the previous operation's effect of 'last_operand'
                    // and then apply the multiplication.
                    // e.g., if we have "A + B", current_val = A+B, last_operand = B.
                    // If we add "*C", new current_val = A + (B*C).
                    // This is achieved by: current_val - last_operand + (last_operand * current_num)
                    path.push('*');
                    path.push_str(&current_num.to_string());
                    backtrack(
                        i + 1,
                        current_val - last_operand + last_operand * current_num,
                        last_operand * current_num,
                        path,
                        num_chars,
                        target,
                        results,
                    );
                    path.truncate(path_len_before_append); // Backtrack path
                }
            }
        }

        let mut path = String::new();
        backtrack(
            0,
            0,
            0,
            &mut path,
            &num_chars,
            target,
            &mut results,
        );

        results
    }
}