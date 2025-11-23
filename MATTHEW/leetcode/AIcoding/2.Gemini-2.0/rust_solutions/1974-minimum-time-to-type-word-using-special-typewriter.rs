impl Solution {
    pub fn min_time_to_type(word: String) -> i32 {
        let mut current = 'a' as u8;
        let mut time = 0;
        for c in word.bytes() {
            let diff = (c as i32 - current as i32).abs();
            time += std::cmp::min(diff, 26 - diff) + 1;
            current = c;
        }
        time
    }
}