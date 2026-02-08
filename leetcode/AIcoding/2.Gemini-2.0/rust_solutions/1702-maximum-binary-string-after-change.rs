impl Solution {
    pub fn maximum_binary_string(binary: String) -> String {
        let mut zeros = 0;
        let mut ones = 0;
        let mut first_zero = -1;

        for (i, c) in binary.chars().enumerate() {
            if c == '0' {
                if first_zero == -1 {
                    first_zero = i as i32;
                }
                zeros += 1;
            } else {
                ones += 1;
            }
        }

        if zeros == 0 {
            return binary;
        }

        let mut result = String::new();
        for _ in 0..binary.len() - zeros {
            result.push('1');
        }

        for _ in 0..zeros - 1 {
            result.push('1');
        }

        result.push('0');

        for _ in 0..ones - (binary.len() - zeros) {
            result.push('1');
        }

        result
    }
}