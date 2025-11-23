impl Solution {
    pub fn shortest_superstring(words: Vec<String>) -> String {
        let n = words.len();
        let mut overlaps = vec![vec![0; n]; n];
        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                let a = words[i].as_bytes();
                let b = words[j].as_bytes();
                let max_possible = a.len().min(b.len());
                let mut max_overlap = 0;
                for k in (1..=max_possible).rev() {
                    if a[a.len() - k..] == b[..k] {
                        max_overlap = k;
                        break;
                    }
                }
                overlaps[i][j] = max_overlap;
            }
        }

        let mut dp = vec![vec![0; n]; 1 << n];
        let mut parent = vec![vec![0; n]; 1 << n];
        for mask in 0..1 << n {
            for bit in 0..n {
                if (mask >> bit) & 1 == 0 {
                    continue;
                }
                let prev_mask = mask ^ (1 << bit);
                if prev_mask == 0 {
                    continue;
                }
                for last in 0..n {
                    if (prev_mask >> last) & 1 == 0 {
                        continue;
                    }
                    let val = dp[prev_mask][last] + overlaps[last][bit];
                    if val > dp[mask][bit] {
                        dp[mask][bit] = val;
                        parent[mask][bit] = last;
                    }
                }
            }
        }

        let mask = (1 << n) - 1;
        let mut max_overlap = 0;
        let mut last = 0;
        for i in 0..n {
            if dp[mask][i] > max_overlap {
                max_overlap = dp[mask][i];
                last = i;
            }
        }

        let mut path = Vec::new();
        let mut current_mask = mask;
        let mut current_last = last;
        path.push(current_last);
        while current_mask != 0 {
            let prev_last = parent[current_mask][current_last];
            if prev_last == 0 && (current_mask ^ (1 << current_last)) == 0 {
                break;
            }
            path.push(prev_last);
            current_mask ^= 1 << current_last;
            current_last = prev_last;
        }
        path.reverse();

        let mut result = words[path[0]].clone();
        for i in 1..path.len() {
            let overlap = overlaps[path[i - 1]][path[i]];
            let word = &words[path[i]];
            result.push_str(&word[overlap..]);
        }

        result
    }
}