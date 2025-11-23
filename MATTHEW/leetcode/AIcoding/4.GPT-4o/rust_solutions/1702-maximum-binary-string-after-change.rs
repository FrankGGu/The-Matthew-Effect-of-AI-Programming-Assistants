impl Solution {
    pub fn maximum_binary_string(binary: String) -> String {
        let mut ones = 0;
        let mut zeros = 0;

        for c in binary.chars() {
            if c == '1' {
                ones += 1;
            } else {
                zeros += 1;
            }
        }

        if zeros == 0 {
            return binary;
        }

        let max_ones = ones + zeros - 1;
        let mut result = String::new();
        result.push_str(&"1".repeat(max_ones));
        result.push('0');

        result
    }
}