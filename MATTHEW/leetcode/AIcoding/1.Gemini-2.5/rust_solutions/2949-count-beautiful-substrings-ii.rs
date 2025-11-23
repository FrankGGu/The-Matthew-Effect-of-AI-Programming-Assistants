use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_beautiful_substrings(s: String, k: i332) -> i32 {
        let n = s.len();
        let k_long = k as i64;

        // Calculate g, the smallest positive integer such that g*g is divisible by k.
        // g = product(p_i^ceil(a_i/2)) for k = product(p_i^a_i)
        let mut temp_k = k_long;
        let mut g: i64 = 1;
        let mut d = 2;
        while d * d <= temp_k {
            if temp_k % d == 0 {
                let mut count = 0;
                while temp_k % d == 0 {
                    count += 1;
                    temp_k /= d;
                }
                // ceil(count / 2)
                let exp_for_g = (count + 1) / 2;
                for _ in 0..exp_for_g {
                    g *= d;
                }
            }
            d += 1;
        }
        if temp_k > 1 {
            g *= temp_k; // Remaining prime factor (exponent is 1, so ceil(1/2) = 1)
        }

        let mut ans = 0;
        let mut v_count = 0;
        let mut c_count = 0;

        // Map: (diff_val, v_prefix_val % g) -> HashMap<v_prefix_val, count>
        // This approach has O(N * N/g) time complexity in the worst case.
        // Memory complexity is O(N).
        let mut map: HashMap<(i32, i64), HashMap<i32, i32>> = HashMap::new();

        // Initial state for empty prefix (index -1, effectively prefix length 0)
        // v_prefix[0] = 0, c_prefix[0] = 0, diff[0] = 0
        // v_prefix[0] % g = 0
        map.entry((0, 0 % g)).or_default().entry(0).or_default().add(1);

        for j in 0..n {
            let ch = s.chars().nth(j).unwrap();
            if "aeiou".contains(ch) {
                v_count += 1;
            } else {
                c_count += 1;
            }

            let current_diff = v_count - c_count;
            let current_v_prefix = v_count;
            let current_v_mod_g = (current_v_prefix as i64) % g;

            if let Some(inner_map) = map.get(&(current_diff, current_v_mod_g)) {
                // We need to find previous prefixes 'i' such that:
                // 1. diff[i] == current_diff
                // 2. v_prefix[i] % g == current_v_prefix % g
                // 3. x = current_v_prefix - v_prefix[i] > 0
                // 4. x is a multiple of g (already handled by 2 and the definition of g)
                // So, we sum counts for all v_prefix_val in inner_map where v_prefix_val < current_v_prefix.
                for (&prev_v_prefix, &count) in inner_map {
                    if prev_v_prefix < current_v_prefix {
                        ans += count;
                    }
                }
            }

            // Add current prefix to map
            map.entry((current_diff, current_v_mod_g))
                .or_default()
                .entry(current_v_prefix)
                .or_default()
                .add(1);
        }

        ans
    }
}

trait AddOne {
    fn add(&mut self, val: i32);
}

impl AddOne for i32 {
    fn add(&mut self, val: i32) {
        *self += val;
    }
}