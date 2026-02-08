impl Solution {
    pub fn magical_string(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        if n <= 3 {
            return 1;
        }

        let n_usize = n as usize;
        let mut s: Vec<u8> = vec![1, 2, 2];
        let mut count_ones = 1;

        let mut reader_ptr = 2;
        let mut next_char_to_append = 1;

        while s.len() < n_usize {
            let count = s[reader_ptr];

            for _ in 0..count {
                if s.len() < n_usize {
                    s.push(next_char_to_append);
                    if next_char_to_append == 1 {
                        count_ones += 1;
                    }
                } else {
                    break;
                }
            }

            next_char_to_append = if next_char_to_append == 1 { 2 } else { 1 };
            reader_ptr += 1;
        }

        count_ones
    }
}