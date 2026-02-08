impl Solution {
    pub fn find_lus_length(strs: Vec<String>) -> i32 {
        let mut max_length = -1;
        let n = strs.len();

        for i in 0..n {
            let mut is_uncommon = true;
            for j in 0..n {
                if i != j && Self::is_subsequence(&strs[i], &strs[j]) {
                    is_uncommon = false;
                    break;
                }
            }
            if is_uncommon {
                max_length = max_length.max(strs[i].len() as i32);
            }
        }

        max_length
    }

    fn is_subsequence(s1: &str, s2: &str) -> bool {
        let mut iter = s2.chars();
        s1.chars().all(|c| iter.by_ref().any(|x| x == c))
    }
}