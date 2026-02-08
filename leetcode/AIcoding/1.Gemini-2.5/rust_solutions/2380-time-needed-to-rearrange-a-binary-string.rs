impl Solution {
    pub fn seconds_to_remove_occurrences(s: String) -> i32 {
        let mut s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();
        let mut seconds = 0;

        loop {
            let mut swaps_to_perform: Vec<usize> = Vec::new();
            for i in 0..n - 1 {
                if s_chars[i] == '0' && s_chars[i+1] == '1' {
                    swaps_to_perform.push(i);
                }
            }

            if swaps_to_perform.is_empty() {
                break;
            }

            seconds += 1;

            for &i in swaps_to_perform.iter() {
                s_chars[i] = '1';
                s_chars[i+1] = '0';
            }
        }

        seconds
    }
}