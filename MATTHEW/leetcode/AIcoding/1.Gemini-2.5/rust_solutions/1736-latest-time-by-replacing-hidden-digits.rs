impl Solution {
    pub fn maximum_time(time: String) -> String {
        let mut chars: Vec<char> = time.chars().collect();

        // Handle hours
        if chars[0] == '?' {
            if chars[1] == '?' {
                chars[0] = '2';
                chars[1] = '3';
            } else if chars[1] >= '0' && chars[1] <= '3' {
                chars[0] = '2';
            } else {
                chars[0] = '1';
            }
        }

        if chars[1] == '?' {
            if chars[0] == '2' {
                chars[1] = '3';
            } else { // chars[0] is '0' or '1'
                chars[1] = '9';
            }
        }

        // Handle minutes
        if chars[3] == '?' {
            chars[3] = '5';
        }
        if chars[4] == '?' {
            chars[4] = '9';
        }

        chars.into_iter().collect()
    }
}