const MOD: i64 = 1_000_000_007;

fn find_good_strings(n: i32, s1: String, s2: String, evil: String) -> i32 {
    let n = n as usize;
    let s1: Vec<char> = s1.chars().collect();
    let s2: Vec<char> = s2.chars().collect();
    let evil: Vec<char> = evil.chars().collect();
    let m = evil.len();

    let mut lps = vec![0; m];
    let mut len = 0;
    let mut i = 1;
    while i < m {
        if evil[i] == evil[len] {
            len += 1;
            lps[i] = len;
            i += 1;
        } else {
            if len != 0 {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i += 1;
            }
        }
    }

    let mut memo = vec![vec![vec![vec![-1; 2]; 2]; m]; n];

    fn dp(
        pos: usize,
        evil_matched: usize,
        tight_lower: bool,
        tight_upper: bool,
        n: usize,
        s1: &[char],
        s2: &[char],
        evil: &[char],
        lps: &[usize],
        memo: &mut Vec<Vec<Vec<Vec<i64>>>>,
    ) -> i64 {
        if evil_matched == evil.len() {
            return 0;
        }
        if pos == n {
            return 1;
        }
        if memo[pos][evil_matched][tight_lower as usize][tight_upper as usize] != -1 {
            return memo[pos][evil_matched][tight_lower as usize][tight_upper as usize];
        }

        let lower = if tight_lower { s1[pos] } else { 'a' };
        let upper = if tight_upper { s2[pos] } else { 'z' };

        let mut res = 0;
        for c in lower..=upper {
            let new_tight_lower = tight_lower && (c == s1[pos]);
            let new_tight_upper = tight_upper && (c == s2[pos]);

            let mut new_evil_matched = evil_matched;
            while new_evil_matched > 0 && c != evil[new_evil_matched] {
                new_evil_matched = lps[new_evil_matched - 1];
            }
            if c == evil[new_evil_matched] {
                new_evil_matched += 1;
            }

            res += dp(
                pos + 1,
                new_evil_matched,
                new_tight_lower,
                new_tight_upper,
                n,
                s1,
                s2,
                evil,
                lps,
                memo,
            );
            res %= MOD;
        }

        memo[pos][evil_matched][tight_lower as usize][tight_upper as usize] = res;
        res
    }

    let res = dp(0, 0, true, true, n, &s1, &s2, &evil, &lps, &mut memo);
    (res % MOD) as i32
}