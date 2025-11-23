impl Solution {
    pub fn rune_reserve(mut runes: Vec<i32>) -> i32 {
        if runes.is_empty() {
            return 0;
        }
        runes.sort();
        let mut max_len = 1;
        let mut current_len = 1;
        for i in 1..runes.len() {
            if runes[i] - runes[i - 1] <= 1 {
                current_len += 1;
                max_len = max_len.max(current_len);
            } else {
                current_len = 1;
            }
        }
        max_len
    }
}