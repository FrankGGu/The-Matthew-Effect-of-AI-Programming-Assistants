impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let mut res = 0;
        let mut len = 0;
        let mod_val = 1_000_000_007;

        for i in 1..=n {
            if i & (i - 1) == 0 {
                len += 1;
            }
            res = ((res << len) % mod_val + i) % mod_val;
        }

        res
    }
}