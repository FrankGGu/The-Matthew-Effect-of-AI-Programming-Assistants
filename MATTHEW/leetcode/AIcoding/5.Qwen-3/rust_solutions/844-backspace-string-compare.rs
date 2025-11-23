struct Solution;

impl Solution {
    pub fn backspace_compare(s: String, t: String) -> bool {
        let mut i = s.len();
        let mut j = t.len();
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        loop {
            i = Self::get_next_valid_index(&s_bytes, i);
            j = Self::get_next_valid_index(&t_bytes, j);

            if i == 0 && j == 0 {
                return true;
            }

            if i == 0 || j == 0 {
                return false;
            }

            if s_bytes[i - 1] != t_bytes[j - 1] {
                return false;
            }

            i -= 1;
            j -= 1;
        }
    }

    fn get_next_valid_index(bytes: &[u8], index: usize) -> usize {
        let mut skip = 0;
        let mut i = index;

        while i > 0 {
            if bytes[i - 1] == b'#' {
                skip += 1;
                i -= 1;
            } else if skip > 0 {
                skip -= 1;
                i -= 1;
            } else {
                break;
            }
        }

        i
    }
}