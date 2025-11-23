impl Solution {
    pub fn min_time_to_type(word: String) -> i32 {
        let mut current = 'a';
        let mut time = 0;
        for c in word.chars() {
            let diff = (c as i32 - current as i32).abs();
            let move_time = diff.min(26 - diff);
            time += move_time + 1;
            current = c;
        }
        time
    }
}