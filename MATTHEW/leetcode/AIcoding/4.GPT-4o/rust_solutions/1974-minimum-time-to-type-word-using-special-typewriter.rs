impl Solution {
    pub fn min_time_to_type(word: String) -> i32 {
        let mut time = 0;
        let mut prev_char = 'a';

        for c in word.chars() {
            let distance = ((c as i32 - prev_char as i32 + 26) % 26).abs();
            time += distance + 1;
            prev_char = c;
        }

        time
    }
}