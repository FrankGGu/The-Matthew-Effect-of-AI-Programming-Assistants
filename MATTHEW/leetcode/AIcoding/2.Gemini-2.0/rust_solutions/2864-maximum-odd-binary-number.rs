impl Solution {
    pub fn maximum_odd_binary_number(s: String) -> String {
        let mut ones = 0;
        for c in s.chars() {
            if c == '1' {
                ones += 1;
            }
        }

        if ones == 0 {
            return s;
        }

        let mut result = String::new();
        for _ in 0..ones - 1 {
            result.push('1');
        }

        for _ in 0..s.len() - ones {
            result.push('0');
        }

        result.push('1');

        result
    }
}