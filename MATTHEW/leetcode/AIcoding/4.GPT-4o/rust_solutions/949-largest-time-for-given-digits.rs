impl Solution {
    pub fn largest_time_from_digits(arr: Vec<i32>) -> String {
        let mut max_time = -1;
        for &h1 in &arr {
            for &h2 in &arr {
                if h1 == h2 { continue; }
                for &m1 in &arr {
                    for &m2 in &arr {
                        if m1 == m2 || m1 == h1 || m1 == h2 { continue; }
                        let hour = h1 * 10 + h2;
                        let minute = m1 * 10 + m2;
                        if hour < 24 && minute < 60 {
                            max_time = max_time.max(hour * 60 + minute);
                        }
                    }
                }
            }
        }
        if max_time == -1 {
            return "".to_string();
        }
        let hours = max_time / 60;
        let minutes = max_time % 60;
        format!("{:02}:{:02}", hours, minutes)
    }
}