pub fn find_good_strings(n: i32, s1: String, s2: String, evil: String) -> i32 {
    let mod_val = 1_000_000_007;
    let m = evil.len();
    let mut dp = vec![vec![-1; m + 1]; n as usize + 1];
    let mut prefix = vec![0; m + 1];

    for i in 1..m {
        let mut j = prefix[i];
        while j > 0 && evil.chars().nth(j) != evil.chars().nth(i) {
            j = prefix[j];
        }
        if evil.chars().nth(j) == evil.chars().nth(i) {
            j += 1;
        }
        prefix[i + 1] = j;
    }

    fn dfs(pos: usize, evil_pos: usize, is_prefix1: bool, is_prefix2: bool, n: i32, s1: &Vec<char>, s2: &Vec<char>, evil: &Vec<char>, dp: &mut Vec<Vec<i32>>) -> i32 {
        if evil_pos == evil.len() {
            return 0;
        }
        if pos == n as usize {
            return 1;
        }
        if dp[pos][evil_pos] != -1 {
            return dp[pos][evil_pos];
        }

        let mut result = 0;
        let start = if is_prefix1 { s1[pos] } else { 'a' };
        let end = if is_prefix2 { s2[pos] } else { 'z' };

        for c in start..=end {
            let next_evil_pos = if c == evil[evil_pos] {
                evil_pos + 1
            } else {
                prefix[evil_pos]
            };
            result = (result + dfs(pos + 1, next_evil_pos, is_prefix1 && c == s1[pos], is_prefix2 && c == s2[pos], n, s1, s2, evil, dp)) % mod_val;
        }

        dp[pos][evil_pos] = result;
        result
    }

    let s1_chars: Vec<char> = s1.chars().collect();
    let s2_chars: Vec<char> = s2.chars().collect();
    let evil_chars: Vec<char> = evil.chars().collect();

    dfs(0, 0, true, true, n, &s1_chars, &s2_chars, &evil_chars, &mut dp)
}