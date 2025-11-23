impl Solution {
    pub fn compress(chars: &mut Vec<char>) -> i32 {
        let mut write_ptr: usize = 0;
        let mut read_ptr: usize = 0;
        let n = chars.len();

        while read_ptr < n {
            let current_char = chars[read_ptr];
            let mut count = 0;

            while read_ptr < n && chars[read_ptr] == current_char {
                read_ptr += 1;
                count += 1;
            }

            chars[write_ptr] = current_char;
            write_ptr += 1;

            if count > 1 {
                let s_count = count.to_string();
                for c in s_count.chars() {
                    chars[write_ptr] = c;
                    write_ptr += 1;
                }
            }
        }

        write_ptr as i32
    }
}