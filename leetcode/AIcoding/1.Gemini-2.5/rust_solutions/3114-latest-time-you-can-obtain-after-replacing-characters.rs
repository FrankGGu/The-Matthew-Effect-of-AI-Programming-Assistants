impl Solution {
    pub fn latest_time_you_can_obtain_after_replacing_characters(s: String) -> String {
        let mut s_chars: Vec<char> = s.chars().collect();

        // Handle hours (HH)
        if s_chars[0] == '?' {
            if s_chars[1] == '?' || s_chars[1] <= '3' {
                s_chars[0] = '1';
            } else { // s_chars[1] is '4' through '9'
                s_chars[0] = '0';
            }
        }

        if s_chars[1] == '?' {
            if s_chars[0] == '2' {
                s_chars[1] = '3';
            } else { // s_chars[0] is '0' or '1'
                s_chars[1] = '9';
            }
        }

        // Handle minutes (MM)
        if s_chars[3] == '?' {
            s_chars[3] = '5';
        }
        if s_chars[4] == '?' {
            s_chars[4] = '9';
        }

        s_chars.into_iter().collect()
    }
}