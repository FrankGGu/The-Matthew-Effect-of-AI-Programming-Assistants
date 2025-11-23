impl Solution {
    pub fn minimum_pushes(word: String) -> i32 {
        let n = word.len();
        let mut ans = 0;
        for i in 0..n {
            ans += (i / 8 + 1) as i32;
        }
        ans
    }
}