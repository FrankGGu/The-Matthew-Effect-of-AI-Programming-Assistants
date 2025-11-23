impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let n = words.len();
        for i in 0..n {
            for j in i + 1..n {
                let a = &words[i];
                let b = &words[j];
                if b.starts_with(a) && b.ends_with(a) {
                    count += 1;
                }
            }
        }
        count
    }
}