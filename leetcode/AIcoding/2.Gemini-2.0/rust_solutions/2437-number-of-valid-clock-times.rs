impl Solution {
    pub fn count_time(time: String) -> i32 {
        let time_chars: Vec<char> = time.chars().collect();
        let mut count = 1;

        if time_chars[0] == '?' && time_chars[1] == '?' {
            count *= 24;
        } else if time_chars[0] == '?' {
            if time_chars[1] <= '3' {
                count *= 3;
            } else {
                count *= 2;
            }
        } else if time_chars[1] == '?' {
            if time_chars[0] == '2' {
                count *= 4;
            } else {
                count *= 10;
            }
        }

        if time_chars[3] == '?' && time_chars[4] == '?' {
            count *= 60;
        } else if time_chars[3] == '?' {
            count *= 6;
        } else if time_chars[4] == '?' {
            count *= 10;
        }

        count
    }
}