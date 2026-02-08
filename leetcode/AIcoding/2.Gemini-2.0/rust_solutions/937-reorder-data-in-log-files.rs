impl Solution {
    pub fn reorder_log_files(logs: Vec<String>) -> Vec<String> {
        let mut letter_logs: Vec<String> = Vec::new();
        let mut digit_logs: Vec<String> = Vec::new();

        for log in logs {
            let parts: Vec<&str> = log.split_whitespace().collect();
            if parts[1].chars().next().unwrap().is_digit(10) {
                digit_logs.push(log);
            } else {
                letter_logs.push(log);
            }
        }

        letter_logs.sort_by(|a, b| {
            let a_content = a.split_whitespace().skip(1).collect::<Vec<&str>>().join(" ");
            let b_content = b.split_whitespace().skip(1).collect::<Vec<&str>>().join(" ");

            if a_content != b_content {
                a_content.cmp(&b_content)
            } else {
                a.split_whitespace().next().unwrap().cmp(b.split_whitespace().next().unwrap())
            }
        });

        letter_logs.extend(digit_logs);
        letter_logs
    }
}