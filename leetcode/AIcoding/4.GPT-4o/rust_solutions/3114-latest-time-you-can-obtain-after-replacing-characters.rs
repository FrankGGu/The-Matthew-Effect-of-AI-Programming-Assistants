impl Solution {
    pub fn maximum_time(s: String) -> String {
        let mut result = s.chars().collect::<Vec<_>>();
        if result[0] == '?' {
            result[0] = if result[1] == '?' || result[1] < '4' { '2' } else { '1' };
        }
        if result[1] == '?' {
            result[1] = if result[0] == '2' { '3' } else { '9' };
        }
        if result[3] == '?' {
            result[3] = '5';
        }
        if result[4] == '?' {
            result[4] = '9';
        }
        result.iter().collect()
    }
}