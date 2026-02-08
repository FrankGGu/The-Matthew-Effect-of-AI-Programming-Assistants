impl Solution {
    pub fn compress(chars: &mut Vec<char>) -> i32 {
        let mut write = 0;
        let mut read = 0;
        let n = chars.len();

        while read < n {
            let current_char = chars[read];
            let mut count = 0;

            while read < n && chars[read] == current_char {
                read += 1;
                count += 1;
            }

            chars[write] = current_char;
            write += 1;

            if count > 1 {
                for c in count.to_string().chars() {
                    chars[write] = c;
                    write += 1;
                }
            }
        }

        write as i32
    }
}