impl Solution {
    pub fn seconds_to_remove_occurrences(s: String) -> i32 {
        let mut s = s.chars().collect::<Vec<_>>();
        let mut seconds = 0;

        while s.windows(2).any(|w| w == &['0', '1']) {
            let mut new_s = s.clone();
            for i in 1..s.len() {
                if s[i - 1] == '0' && s[i] == '1' {
                    new_s[i - 1] = '1';
                    new_s[i] = '0';
                }
            }
            s = new_s;
            seconds += 1;
        }

        seconds
    }
}