impl Solution {
    pub fn total_characters(words: Vec<String>) -> i32 {
        let mut count = 0;
        for word in words {
            count += word.len() as i32;
        }
        count
    }
}