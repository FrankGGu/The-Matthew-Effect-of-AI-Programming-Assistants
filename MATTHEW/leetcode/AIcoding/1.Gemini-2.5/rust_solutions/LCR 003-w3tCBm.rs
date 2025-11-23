impl Solution {
    pub fn count_bits(n: i332) -> Vec<i32> {
        let n = n as usize;
        let mut ans = vec![0; n + 1];

        for i in 1..=n {
            ans[i] = ans[i & (i - 1)] + 1;
        }

        ans
    }
}