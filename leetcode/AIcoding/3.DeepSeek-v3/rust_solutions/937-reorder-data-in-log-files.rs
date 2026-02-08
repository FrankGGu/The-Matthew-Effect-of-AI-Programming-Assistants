impl Solution {
    pub fn reorder_log_files(logs: Vec<String>) -> Vec<String> {
        let mut letter_logs = Vec::new();
        let mut digit_logs = Vec::new();

        for log in logs {
            let parts: Vec<&str> = log.splitn(2, ' ').collect();
            if parts[1].chars().next().unwrap().is_ascii_digit() {
                digit_logs.push(log);
            } else {
                letter_logs.push(log);
            }
        }

        letter_logs.sort_by(|a, b| {
            let a_parts: Vec<&str> = a.splitn(2, ' ').collect();
            let b_parts: Vec<&str> = b.splitn(2, ' ').collect();
            let content_cmp = a_parts[1].cmp(b_parts[1]);
            if content_cmp == std::cmp::Ordering::Equal {
                a_parts[0].cmp(b_parts[0])
            } else {
                content_cmp
            }
        });

        letter_logs.extend(digit_logs);
        letter_logs
    }
}