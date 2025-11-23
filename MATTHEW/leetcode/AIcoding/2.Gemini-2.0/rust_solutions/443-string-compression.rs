impl Solution {
    pub fn compress(chars: &mut Vec<char>) -> i32 {
        let mut anchor = 0;
        let mut write = 0;

        for read in 0..chars.len() {
            if read + 1 == chars.len() || chars[read + 1] != chars[anchor] {
                chars[write] = chars[anchor];
                write += 1;

                let count = read - anchor + 1;
                if count > 1 {
                    for digit in count.to_string().chars() {
                        chars[write] = digit;
                        write += 1;
                    }
                }
                anchor = read + 1;
            }
        }

        chars.truncate(write);
        write as i32
    }
}