impl Solution {
    pub fn compress(chars: &mut Vec<char>) -> i32 {
        let mut write = 0;
        let mut read = 0;

        while read < chars.len() {
            let current_char = chars[read];
            let mut count = 0;

            while read < chars.len() && chars[read] == current_char {
                read += 1;
                count += 1;
            }

            chars[write] = current_char;
            write += 1;

            if count > 1 {
                for digit in count.to_string().chars() {
                    chars[write] = digit;
                    write += 1;
                }
            }
        }

        chars.truncate(write);
        write as i32
    }
}