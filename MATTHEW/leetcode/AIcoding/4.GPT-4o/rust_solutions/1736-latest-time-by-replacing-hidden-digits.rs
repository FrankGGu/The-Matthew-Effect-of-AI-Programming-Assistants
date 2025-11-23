impl Solution {
    pub fn maximum_time(time: String) -> String {
        let mut time_chars: Vec<char> = time.chars().collect();

        if time_chars[0] == '?' {
            time_chars[0] = if time_chars[1] == '?' || time_chars[1] < '4' { '2' } else { '1' };
        }
        if time_chars[1] == '?' {
            time_chars[1] = if time_chars[0] == '2' { '3' } else { '9' };
        }
        if time_chars[3] == '?' {
            time_chars[3] = '5';
        }
        if time_chars[4] == '?' {
            time_chars[4] = '9';
        }

        time_chars.iter().collect()
    }
}