impl Solution {
    pub fn shortest_superstring(words: Vec<String>) -> String {
        let n = words.len();
        let mut adj = vec![vec![0; n]; n];
        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                let w1 = &words[i];
                let w2 = &words[j];
                let m = w1.len();
                let l = w2.len();
                let mut k = 0;
                while k < m && k < l && w1[m - k..] == w2[0..k] {
                    k += 1;
                }
                adj[i][j] = k - 1;
                while adj[i][j] >= 0 && w1[m - adj[i][j]..] != w2[0..adj[i][j]] {
                    adj[i][j] -= 1;
                }

                adj[i][j] += 1;
            }
        }

        let mut dp = vec![vec![String::new(); n]; 1 << n];
        let mut parent = vec![vec![0; n]; 1 << n];

        for mask in 1..(1 << n) {
            for i in 0..n {
                if (mask & (1 << i)) > 0 {
                    if mask == (1 << i) {
                        dp[mask][i] = words[i].clone();
                    } else {
                        for j in 0..n {
                            if i != j && (mask & (1 << j)) > 0 {
                                let prev_mask = mask ^ (1 << i);
                                let temp = dp[prev_mask][j].clone() + &words[i][adj[j][i]..];
                                if dp[mask][i].is_empty() || temp.len() < dp[mask][i].len() {
                                    dp[mask][i] = temp;
                                    parent[mask][i] = j;
                                }
                            }
                        }
                    }
                }
            }
        }

        let mut mask = (1 << n) - 1;
        let mut last = 0;
        for i in 1..n {
            if dp[mask][i].len() < dp[mask][last].len() {
                last = i;
            }
        }

        let mut result = String::new();
        while mask > 0 {
            let prev = parent[mask][last];
            if prev == 0 && mask == (1 << last) {
                result = dp[mask][last].clone();
                break;
            }
            if mask == (1 << last){
                result = dp[mask][last].clone();
                break;
            }

            let prev_mask = mask ^ (1 << last);
            mask = prev_mask;
            last = prev;

            if mask == 0 {
                break;
            }
        }

        result
    }
}