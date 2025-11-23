impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pat: Vec<char>) -> i32 {
        let n = nums.len();
        let m = pat.len();
        if m == 0 {
            return 0;
        }
        if n < m {
            return 0;
        }

        let mut pattern_map = HashMap::new();
        for (i, &c) in pat.iter().enumerate() {
            pattern_map.insert(c, i);
        }

        let mut result = 0;
        let mut current = 0;
        let mut map = HashMap::new();

        for i in 0..n {
            let num = nums[i];
            let key = match num {
                1 => 'a',
                2 => 'b',
                _ => 'c',
            };
            map.entry(key).or_insert(0);
            *map.get_mut(&key).unwrap() += 1;

            if i >= m - 1 {
                let mut match_count = 0;
                for j in 0..m {
                    let c = pat[j];
                    let key = match nums[i - m + 1 + j] {
                        1 => 'a',
                        2 => 'b',
                        _ => 'c',
                    };
                    if *map.get(&key).unwrap() > 0 {
                        match_count += 1;
                    }
                }
                if match_count == m {
                    result += 1;
                }
            }
        }

        result
    }
}
}