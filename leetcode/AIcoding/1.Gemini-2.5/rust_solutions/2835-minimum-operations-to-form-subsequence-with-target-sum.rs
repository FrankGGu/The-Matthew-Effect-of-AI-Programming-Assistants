use std::collections::BTreeMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: i32) -> i64 {
        let mut counts: BTreeMap<i32, i64> = BTreeMap::new();
        let mut total_sum: i64 = 0;

        for &num in &nums {
            let power = num.trailing_zeros() as i32;
            *counts.entry(power).or_insert(0) += 1;
            total_sum += num as i64;
        }

        if total_sum < target as i64 {
            return -1;
        }

        let mut ans: i64 = 0;
        let mut current_available_sum_bits: i64 = 0;

        for i in 0..61 {
            current_available_sum_bits += counts.get(&i).unwrap_or(&0) * (1 << i);

            if ((target >> i) & 1) == 1 {
                if current_available_sum_bits >= (1 << i) {
                    current_available_sum_bits -= (1 << i);
                } else {
                    let mut found_j = -1;
                    for j in (i + 1)..61 {
                        if *counts.get(&j).unwrap_or(&0) > 0 {
                            found_j = j;
                            break;
                        }
                    }

                    if found_j == -1 {
                        return -1;
                    }

                    *counts.entry(found_j).or_insert(0) -= 1;
                    ans += found_j - i;
                    current_available_sum_bits += (1 << found_j) - (1 << i);
                }
            }

            current_available_sum_bits /= 2;
        }

        ans
    }
}