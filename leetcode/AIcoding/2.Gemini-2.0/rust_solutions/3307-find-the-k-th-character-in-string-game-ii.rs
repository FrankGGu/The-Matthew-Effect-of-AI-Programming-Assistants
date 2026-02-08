impl Solution {
    pub fn find_kth_character(n: i32, k: i32) -> char {
        let mut k = k as i64;
        let mut current = 0;
        let mut current_char = 'a';

        while current < n {
            let len = 1 << (n - current - 1);

            if k <= len {
                current += 1;
            } else {
                k -= len;
                current += 1;
                current_char = if current_char == 'a' { 'b' } else { 'a' };
            }
        }

        current_char
    }
}