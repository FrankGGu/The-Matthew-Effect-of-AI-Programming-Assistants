impl Solution {
    pub fn interpret(command: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        while i < command.len() {
            if command.chars().nth(i).unwrap() == 'G' {
                result.push('G');
                i += 1;
            } else if command.chars().nth(i).unwrap() == '(' {
                if command.chars().nth(i + 1).unwrap() == ')' {
                    result.push('o');
                    i += 2;
                } else {
                    result.push_str("al");
                    i += 4;
                }
            }
        }
        result
    }
}