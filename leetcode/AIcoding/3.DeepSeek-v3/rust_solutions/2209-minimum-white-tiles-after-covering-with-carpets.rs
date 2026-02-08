impl Solution {
    pub fn minimum_white_tiles(floor: String, num_carpets: i32, carpet_len: i32) -> i32 {
        let floor_chars: Vec<char> = floor.chars().collect();
        let n = floor_chars.len();
        let num_carpets = num_carpets as usize;
        let carpet_len = carpet_len as usize;

        if num_carpets * carpet_len >= n {
            return 0;
        }

        let mut dp = vec![vec![0; num_carpets + 1]; n + 1];

        for i in 1..=n {
            for k in 0..=num_carpets {
                let skip = dp[i - 1][k] + if floor_chars[i - 1] == '1' { 1 } else { 0 };
                if k == 0 {
                    dp[i][k] = skip;
                } else {
                    let cover = if i >= carpet_len { dp[i - carpet_len][k - 1] } else { 0 };
                    dp[i][k] = std::cmp::min(skip, cover);
                }
            }
        }

        dp[n][num_carpets]
    }
}