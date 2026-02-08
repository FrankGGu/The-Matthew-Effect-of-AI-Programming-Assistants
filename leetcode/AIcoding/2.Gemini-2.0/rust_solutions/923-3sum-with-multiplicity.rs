impl Solution {
    pub fn three_sum_multi(arr: Vec<i32>, target: i32) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for &num in &arr {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut nums: Vec<i32> = counts.keys().cloned().collect();
        nums.sort();

        let mut ans: i64 = 0;
        let mod_val: i64 = 1_000_000_007;

        for i in 0..nums.len() {
            let a = nums[i];
            let target_ab = target - a;
            let mut j = i;
            let mut k = nums.len() - 1;

            while j <= k {
                let b = nums[j];
                let c = nums[k];

                if b + c < target_ab {
                    j += 1;
                } else if b + c > target_ab {
                    k -= 1;
                } else {
                    if a == b && b == c {
                        let count_a = counts[&a] as i64;
                        ans = (ans + count_a * (count_a - 1) * (count_a - 2) / 6) % mod_val;
                        break;
                    } else if a == b && b != c {
                        let count_a = counts[&a] as i64;
                        let count_c = counts[&c] as i64;
                        ans = (ans + count_a * (count_a - 1) / 2 * count_c) % mod_val;
                        j += 1;
                        k -= 1;
                    } else if a != b && b == c {
                        let count_a = counts[&a] as i64;
                        let count_b = counts[&b] as i64;
                        ans = (ans + count_a * count_b * (count_b - 1) / 2) % mod_val;
                        j += 1;
                        k -= 1;
                    } else {
                        let count_a = counts[&a] as i64;
                        let count_b = counts[&b] as i64;
                        let count_c = counts[&c] as i64;
                        ans = (ans + count_a * count_b * count_c) % mod_val;
                        j += 1;
                        k -= 1;
                    }
                }
            }
        }

        ans as i32
    }
}