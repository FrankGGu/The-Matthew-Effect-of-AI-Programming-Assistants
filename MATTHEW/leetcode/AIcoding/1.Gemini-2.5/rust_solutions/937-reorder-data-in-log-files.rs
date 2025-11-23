use std::cmp::Ordering;

struct LogParts<'a> {
    identifier: &'a str,
    content: &'a str,
    is_digit: bool,
}

impl<'a> LogParts<'a> {
    fn new(log_str: &'a str) -> Self {
        let (identifier, content) = log_str.split_once(' ').unwrap();
        let is_digit = content.chars().next().unwrap().is_ascii_digit();
        LogParts {
            identifier,
            content,
            is_digit,
        }
    }
}

impl Solution {
    pub fn reorder_log_files(mut logs: Vec<String>) -> Vec<String> {
        logs.sort_by(|a, b| {
            let log_a = LogParts::new(a);
            let log_b = LogParts::new(b);

            match (log_a.is_digit, log_b.is_digit) {
                (false, false) => { // Both letter-logs
                    let content_cmp = log_a.content.cmp(log_b.content);
                    if content_cmp == Ordering::Equal {
                        log_a.identifier.cmp(log_b.identifier)
                    } else {
                        content_cmp
                    }
                }
                (false, true) => Ordering::Less,    // a is letter-log, b is digit-log
                (true, false) => Ordering::Greater, // a is digit-log, b is letter-log
                (true, true) => Ordering::Equal,    // Both digit-logs
            }
        });
        logs
    }
}