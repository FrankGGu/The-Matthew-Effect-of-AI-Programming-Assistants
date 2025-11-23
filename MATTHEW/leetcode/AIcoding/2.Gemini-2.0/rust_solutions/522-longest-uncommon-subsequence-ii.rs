impl Solution {
    pub fn find_lu_slength(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let mut ans = -1;
        for i in 0..n {
            let mut uncommon = true;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if Self::is_subsequence(&strs[i], &strs[j]) {
                    uncommon = false;
                    break;
                }
            }
            if uncommon {
                ans = ans.max(strs[i].len() as i32);
            }
        }
        ans
    }

    fn is_subsequence(s: &String, t: &String) -> bool {
        let mut i = 0;
        let mut j = 0;
        while i < s.len() && j < t.len() {
            if s.chars().nth(i) == t.chars().nth(j) {
                i += 1;
            }
            j += 1;
        }
        i == s.len()
    }
}