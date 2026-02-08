impl Solution {
    pub fn maximum_binary_string(binary: String) -> String {
        let mut zeros = 0;
        let mut first_zero_pos = None;
        let binary_chars: Vec<char> = binary.chars().collect();

        for (i, &c) in binary_chars.iter().enumerate() {
            if c == '0' {
                zeros += 1;
                if first_zero_pos.is_none() {
                    first_zero_pos = Some(i);
                }
            }
        }

        if zeros <= 1 {
            return binary;
        }

        let mut result = vec!['1'; binary_chars.len()];
        if let Some(pos) = first_zero_pos {
            result[pos + zeros - 1] = '0';
        }

        result.into_iter().collect()
    }
}