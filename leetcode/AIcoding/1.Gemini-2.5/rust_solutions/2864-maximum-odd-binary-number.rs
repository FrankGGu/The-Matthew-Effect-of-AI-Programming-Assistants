impl Solution {
    pub fn maximum_odd_binary_number(s: String) -> String {
        let mut ones_count = 0;
        for c in s.chars() {
            if c == '1' {
                ones_count += 1;
            }
        }

        let n = s.len();
        let zeros_count = n - ones_count;

        let mut result = String::with_capacity(n);

        for _ in 0..(ones_count - 1) {
            result.push('1');
        }

        for _ in 0..zeros_count {
            result.push('0');
        }

        result.push('1');

        result
    }
}