impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i32 {
        let n = words.len();
        let mut count = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                let s_i = &words[i];
                let s_j = &words[j];

                if s_j.starts_with(s_i) && s_j.ends_with(s_i) {
                    count += 1;
                }
            }
        }
        count
    }
}