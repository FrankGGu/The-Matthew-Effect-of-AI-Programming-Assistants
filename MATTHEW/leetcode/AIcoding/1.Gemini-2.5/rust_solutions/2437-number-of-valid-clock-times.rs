impl Solution {
    pub fn count_time(time: String) -> i32 {
        let mut count = 0;
        let time_chars: Vec<char> = time.chars().collect();

        let matches = |pattern_slice: &[char], candidate_str: &str| -> bool {
            let candidate_chars: Vec<char> = candidate_str.chars().collect();
            (pattern_slice[0] == '?' || pattern_slice[0] == candidate_chars[0]) &&
            (pattern_slice[1] == '?' || pattern_slice[1] == candidate_chars[1])
        };

        let hour_pattern = &[time_chars[0], time_chars[1]];
        let minute_pattern = &[time_chars[3], time_chars[4]];

        for h in 0..24 {
            let h_str = format!("{:02}", h);
            if matches(hour_pattern, &h_str) {
                for m in 0..60 {
                    let m_str = format!("{:02}", m);
                    if matches(minute_pattern, &m_str) {
                        count += 1;
                    }
                }
            }
        }

        count
    }
}