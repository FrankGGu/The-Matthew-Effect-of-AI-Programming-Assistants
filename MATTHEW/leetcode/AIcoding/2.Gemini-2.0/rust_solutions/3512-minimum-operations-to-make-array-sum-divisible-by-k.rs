impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        if k == 1 {
            return 0;
        }

        let mut sum: i64 = nums.iter().map(|&x| x as i64).sum();

        if sum % k as i64 == 0 {
            return 0;
        }

        let mut ans = -1;
        let mut prefix_sum: i64 = 0;
        let n = nums.len();

        for i in 0..n {
            prefix_sum = (prefix_sum + nums[i] as i64) % k as i64;
            if prefix_sum < 0 {
                prefix_sum += k as i64;
            }

            let target = (sum % k as i64 - prefix_sum + k as i64) % k as i64;

            if target < 0 {
                continue;
            }

            if target == 0 {
                if ans == -1 || i as i32 + 1 < ans {
                    ans = i as i32 + 1;
                }
            }
        }

        let mut suffix_sum: i64 = 0;

        for i in (0..n).rev() {
            suffix_sum = (suffix_sum + nums[i] as i64) % k as i64;
            if suffix_sum < 0 {
                suffix_sum += k as i64;
            }

            let target = (sum % k as i64 - suffix_sum + k as i64) % k as i64;

            if target < 0 {
                continue;
            }

            if target == 0 {
                if ans == -1 || (n - i) as i32 < ans {
                    ans = (n - i) as i32;
                }
            }
        }

        prefix_sum = 0;
        let mut map: std::collections::HashMap<i64, usize> = std::collections::HashMap::new();
        map.insert(0, -1 as usize);

        for i in 0..n {
            prefix_sum = (prefix_sum + nums[i] as i64) % k as i64;
            if prefix_sum < 0 {
                prefix_sum += k as i64;
            }

            let need = (sum % k as i64 - prefix_sum + k as i64) % k as i64;

            if map.contains_key(&need) {
                let start = map.get(&need).unwrap();
                let len = i as i32 - *start as i32;
                if ans == -1 || len < ans {
                    ans = len;
                }
            }
            if !map.contains_key(&prefix_sum) {
                map.insert(prefix_sum, i);
            }
        }

        ans
    }
}