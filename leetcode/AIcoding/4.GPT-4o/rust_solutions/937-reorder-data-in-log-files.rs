impl Solution {
    pub fn reorder_log_files(logs: Vec<String>) -> Vec<String> {
        let mut letters = Vec::new();
        let mut digits = Vec::new();

        for log in logs {
            if log.split_whitespace().nth(1).unwrap().chars().next().unwrap().is_digit(10) {
                digits.push(log);
            } else {
                letters.push(log);
            }
        }

        letters.sort_by(|a, b| {
            let a_parts: Vec<&str> = a.split_whitespace().collect();
            let b_parts: Vec<&str> = b.split_whitespace().collect();
            let cmp = a_parts[1..].cmp(b_parts[1..]);
            if cmp == std::cmp::Ordering::Equal {
                a_parts[0].cmp(b_parts[0])
            } else {
                cmp
            }
        });

        letters.append(&mut digits);
        letters
    }
}