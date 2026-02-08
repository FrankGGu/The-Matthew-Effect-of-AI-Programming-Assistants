impl Solution {
    pub fn length_longest_path(input: String) -> i32 {
        let mut max_len = 0;
        let mut stack = vec![0];

        for line in input.split('\n') {
            let depth = line.chars().take_while(|&c| c == '\t').count();
            let name = &line[depth..];

            while depth + 1 < stack.len() {
                stack.pop();
            }

            let current_len = stack.last().unwrap() + name.len();
            if name.contains('.') {
                max_len = max_len.max(current_len);
            } else {
                stack.push(current_len + 1);
            }
        }

        max_len as i32
    }
}