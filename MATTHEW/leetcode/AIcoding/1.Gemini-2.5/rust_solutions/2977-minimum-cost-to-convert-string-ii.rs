use std::collections::HashMap;
use std::cmp::min;

const INF: i64 = i64::MAX / 2; // Use a large enough value to represent infinity

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct StringHash {
    h1: u64,
    h2: u64,
    len: usize,
}

struct RollingHasher {
    p1: u64,
    m1: u64,
    p2: u64,
    m2: u64,
    pow1: Vec<u64>,
    pow2: Vec<u64>,
}

impl RollingHasher {
    fn new(max_len: usize) -> Self {
        let p1 = 31; 
        let m1 = 1_000_000_007; 
        let p2 = 37; 
        let m2 = 1_000_000_009; 

        let mut pow1 = vec![1; max_len + 1];
        let mut pow2 = vec![1; max_len + 1];
        for i in 1..=max_len {
            pow1[i] = (pow1[i - 1] * p1) % m1;
            pow2[i] = (pow2[i - 1] * p2) % m2;
        }
        RollingHasher { p1, m1, p2, m2, pow1, pow2 }
    }

    fn compute_prefix_hashes(&self, s: &str) -> (Vec<u64>, Vec<u64>) {
        let mut prefix_h1 = vec![0; s.len() + 1];
        let mut prefix_h2 = vec![0; s.len() + 1];
        for (i, c) in s.chars().enumerate() {
            let val = (c as u64 - 'a' as u64) + 1; 
            prefix_h1[i + 1] = (prefix_h1[i] * self.p1 + val) % self.m1;
            prefix_h2[i + 1] = (prefix_h2[i] * self.p2 + val) % self.m2;
        }
        (prefix_h1, prefix_h2)
    }

    fn get_substring_hash(&self, prefix_h1: &[u64], prefix_h2: &[u64], start: usize, end: usize) -> StringHash {
        let len = end - start;
        if len == 0 {
            return StringHash { h1: 0, h2: 0, len: 0 }; 
        }

        let mut h1 = prefix_h1[end];
        let h1_prev = prefix_h1[start];
        h1 = (h1 - (h1_prev * self.pow1[len]) % self.m1 + self.m1) % self.m1;

        let mut h2 = prefix_h2[end];
        let h2_prev = prefix_h2[start];
        h2 = (h2 - (h2_prev * self.pow2[len]) % self.m2 + self.m2) % self.m2;

        StringHash { h1, h2, len }
    }

    fn hash_string(&self, s: &str) -> StringHash {
        let mut h1 = 0;
        let mut h2 = 0;
        for c in s.chars() {
            let val = (c as u64 - 'a' as u64) + 1;
            h1 = (h1 * self.p1 + val) % self.m1;
            h2 = (h2 * self.p2 + val) % self.m2;
        }
        StringHash { h1, h2, len: s.len() }
    }
}

impl Solution {
    pub fn minimum_cost(source: String, target: String, original_char: Vec<char>, target_char: Vec<char>, char_cost: Vec<i32>, original_string: Vec<String>, target_string: Vec<String>, string_cost: Vec<i32>) -> i64 {
        let n = source.len();

        let mut char_min_costs = vec![vec![INF; 26]; 26];
        for i in 0..26 {
            char_min_costs[i][i] = 0;
        }

        for i in 0..original_char.len() {
            let u = (original_char[i] as usize) - ('a' as usize);
            let v = (target_char[i] as usize) - ('a' as usize);
            char_min_costs[u][v] = min(char_min_costs[u][v], char_cost[i] as i64);
        }

        for k in 0..26 {
            for i in 0..26 {
                for j in 0..26 {
                    if char_min_costs[i][k] != INF && char_min_costs[k][j] != INF {
                        char_min_costs[i][j] = min(char_min_costs[i][j], char_min_costs[i][k] + char_min_costs[k][j]);
                    }
                }
            }
        }

        let hasher = RollingHasher::new(n);
        let (source_prefix_h1, source_prefix_h2) = hasher.compute_prefix_hashes(&source);
        let (target_prefix_h1, target_prefix_h2) = hasher.compute_prefix_hashes(&target);

        let mut string_conversion_map: HashMap<StringHash, HashMap<StringHash, i64>> = HashMap::new();

        for i in 0..original_string.len() {
            let orig_s = &original_string[i];
            let targ_s = &target_string[i];
            let direct_cost = string_cost[i] as i64;

            if orig_s.len() != targ_s.len() {
                continue; 
            }

            let len = orig_s.len();
            let mut char_wise_cost = 0;
            let mut possible_char_wise = true;
            for k in 0..len {
                let u = (orig_s.chars().nth(k).unwrap() as usize) - ('a' as usize);
                let v = (targ_s.chars().nth(k).unwrap() as usize) - ('a' as usize);
                if char_min_costs[u][v] == INF {
                    possible_char_wise = false;
                    break;
                }
                char_wise_cost += char_min_costs[u][v];
            }

            let effective_cost = if possible_char_wise {
                min(direct_cost, char_wise_cost)
            } else {
                direct_cost
            };

            let orig_s_hash = hasher.hash_string(orig_s);
            let targ_s_hash = hasher.hash_string(targ_s);

            *string_conversion_map
                .entry(orig_s_hash)
                .or_insert_with(HashMap::new)
                .entry(targ_s_hash)
                .or_insert(INF) = min(
                    *string_conversion_map
                        .get(&orig_s_hash)
                        .and_then(|m| m.get(&targ_s_hash))
                        .unwrap_or(&INF),
                    effective_cost
                );
        }

        let mut dp = vec![INF; n + 1];
        dp[0] = 0;

        let source_chars: Vec<char> = source.chars().collect();
        let target_chars: Vec<char> = target.chars().collect();

        for i in 1..=n {
            let s_char_idx = (source_chars[i - 1] as usize) - ('a' as usize);
            let t_char_idx = (target_chars[i - 1] as usize) - ('a' as usize);

            if dp[i - 1] != INF && char_min_costs[s_char_idx][t_char_idx] != INF {
                dp[i] = min(dp[i], dp[i - 1] + char_min_costs[s_char_idx][t_char_idx]);
            }

            for len in 1..=i {
                let j = i - len; 

                let sub_source_hash = hasher.get_substring_hash(&source_prefix_h1, &source_prefix_h2, j, i);
                let sub_target_hash = hasher.get_substring_hash(&target_prefix_h1, &target_prefix_h2, j, i);

                if let Some(cost_s) = string_conversion_map
                    .get(&sub_source_hash)
                    .and_then(|m| m.get(&sub_target_hash))
                {
                    if dp[j] != INF {
                        dp[i] = min(dp[i], dp[j] + cost_s);
                    }
                }
            }
        }

        if dp[n] == INF {
            -1
        } else {
            dp[n]
        }
    }
}