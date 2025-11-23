impl Solution {
    pub fn count_bits(n: i32) -> Vec<i32> {
        let n_usize = n as usize;
        let mut ans = vec![0; n_usize + 1];

        for i in 1..=n_usize {
            ans[i] = ans[i >> 1] + (i as i32 & 1);
        }

        ans
    }
}