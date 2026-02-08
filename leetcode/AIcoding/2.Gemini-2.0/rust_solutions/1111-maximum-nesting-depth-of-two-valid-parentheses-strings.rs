impl Solution {
    pub fn max_depth_after_split(seq: String) -> Vec<i32> {
        let mut ans = vec![0; seq.len()];
        let mut a = 0;
        let mut b = 0;
        for (i, c) in seq.chars().enumerate() {
            if c == '(' {
                if a < b {
                    ans[i] = 0;
                    a += 1;
                } else {
                    ans[i] = 1;
                    b += 1;
                }
            } else {
                if a <= b {
                    ans[i] = 0;
                    b -= 1;
                } else {
                    ans[i] = 1;
                    a -= 1;
                }
            }
        }
        ans
    }
}