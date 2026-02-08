impl Solution {
    pub fn painting_plan(n: i32, k: i32) -> i32 {
        if k == 0 || k == n * n {
            return 1;
        }
        if k < n || k > n * n {
            return 0;
        }
        let mut res = 0;
        for i in 0..=n {
            for j in 0..=n {
                if (i * n + j * n - i * j) == k {
                    res += Self::comb(n, i) * Self::comb(n, j);
                }
            }
        }
        res
    }

    fn comb(n: i32, k: i32) -> i32 {
        if k == 0 {
            return 1;
        }
        let mut res = 1;
        for i in 1..=k {
            res = res * (n - k + i) / i;
        }
        res
    }
}