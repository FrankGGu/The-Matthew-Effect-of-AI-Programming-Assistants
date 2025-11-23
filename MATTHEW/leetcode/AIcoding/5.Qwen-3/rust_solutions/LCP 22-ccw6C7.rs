struct Solution;

impl Solution {
    pub fn is_possible(n: i32, m: i32, k: i32) -> bool {
        let mut k = k;
        let mut count = 0;
        for i in 0..n {
            for j in 0..m {
                if (i + j) % 2 == 0 {
                    count += 1;
                }
            }
        }
        count >= k
    }
}