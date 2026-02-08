impl Solution {
    pub fn total_characters(words: Vec<String>) -> i32 {
        let mut ans = 0;
        for word in words {
            ans += word.len() as i32;
        }
        ans
    }
}