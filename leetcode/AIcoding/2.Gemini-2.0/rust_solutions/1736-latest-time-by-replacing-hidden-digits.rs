impl Solution {
    pub fn latest_time(time: String) -> String {
        let mut time_chars: Vec<char> = time.chars().collect();

        if time_chars[0] == '?' {
            if time_chars[1] == '?' || time_chars[1] <= '3' {
                time_chars[0] = '2';
            } else {
                time_chars[0] = '1';
            }
        }

        if time_chars[1] == '?' {
            if time_chars[0] == '2' {
                time_chars[1] = '3';
            } else {
                time_chars[1] = '9';
            }
        }

        if time_chars[3] == '?' {
            time_chars[3] = '5';
        }

        if time_chars[4] == '?' {
            time_chars[4] = '9';
        }

        time_chars.into_iter().collect()
    }
}