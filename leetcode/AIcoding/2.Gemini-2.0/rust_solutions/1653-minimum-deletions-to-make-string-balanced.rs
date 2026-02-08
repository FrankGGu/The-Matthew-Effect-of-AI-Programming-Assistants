impl Solution {
    pub fn minimum_deletions(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut b_count = 0;
        for &c in &s {
            if c == 'b' {
                b_count += 1;
            }
        }
        let mut ans = b_count;
        let mut a_count = 0;
        for &c in &s {
            if c == 'a' {
                a_count += 1;
            } else {
                b_count -= 1;
            }
            ans = ans.min(a_count + b_count);
        }
        ans
    }
}