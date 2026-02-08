impl Solution {
    pub fn count_time(time: String) -> i32 {
        let chars: Vec<char> = time.chars().collect();
        let mut count = 1;

        match (chars[0], chars[1]) {
            ('?', '?') => count *= 24,
            ('?', b) => {
                if b <= '3' {
                    count *= 3;
                } else {
                    count *= 2;
                }
            },
            (a, '?') => {
                if a == '2' {
                    count *= 4;
                } else {
                    count *= 10;
                }
            },
            _ => (),
        }

        if chars[3] == '?' {
            count *= 6;
        }

        if chars[4] == '?' {
            count *= 10;
        }

        count
    }
}