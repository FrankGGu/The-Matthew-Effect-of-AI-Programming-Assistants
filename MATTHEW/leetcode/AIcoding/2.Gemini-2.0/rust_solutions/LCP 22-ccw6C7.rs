impl Solution {
    pub fn painting_plan(n: i32, k: i32) -> i32 {
        if k > n * n {
            return 0;
        }
        if k == 0 {
            return 1;
        }

        let mut ans = 0;
        for i in 0..=n {
            for j in 0..=n {
                if i * n + j * n - i * j == k {
                    ans += Self::combinations(n, i) * Self::combinations(n, j);
                }
            }
        }
        ans
    }

    fn combinations(n: i32, k: i32) -> i32 {
        if k > n || k < 0 {
            return 0;
        }
        if k == 0 || k == n {
            return 1;
        }
        if k > n / 2 {
            return Self::combinations(n, n - k);
        }

        let mut res = 1;
        for i in 0..k {
            res = res * (n - i) / (i + 1);
        }
        res
    }
}