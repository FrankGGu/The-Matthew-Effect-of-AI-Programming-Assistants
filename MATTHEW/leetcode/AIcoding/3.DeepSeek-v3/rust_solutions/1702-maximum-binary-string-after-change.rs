impl Solution {
    pub fn maximum_binary_string(binary: String) -> String {
        let mut chars: Vec<char> = binary.chars().collect();
        let n = chars.len();
        let mut zeros = 0;
        let mut first_zero_pos = n;

        for i in 0..n {
            if chars[i] == '0' {
                zeros += 1;
                if first_zero_pos == n {
                    first_zero_pos = i;
                }
            }
        }

        if zeros <= 1 {
            return binary;
        }

        let pos = first_zero_pos + zeros - 1;
        for i in 0..n {
            chars[i] = if i == pos { '0' } else { '1' };
        }

        chars.into_iter().collect()
    }
}