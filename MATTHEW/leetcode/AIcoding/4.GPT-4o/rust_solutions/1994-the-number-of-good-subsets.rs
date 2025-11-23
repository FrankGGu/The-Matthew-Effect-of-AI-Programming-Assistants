use std::collections::HashMap;

impl Solution {
    pub fn count_good_subsets(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut dp = vec![0; 1 << 10];
        let mut total_ones = 1;

        for &num in &nums {
            if num == 1 {
                total_ones += 1;
            } else {
                let mut mask = 0;
                let mut valid = true;
                for i in 2..=30 {
                    if num % i == 0 {
                        let mut bit = 1 << (i - 2);
                        while num % i == 0 {
                            if (mask & bit) != 0 {
                                valid = false;
                                break;
                            }
                            mask |= bit;
                            num /= i;
                        }
                    }
                    if !valid {
                        break;
                    }
                }
                if valid {
                    *count.entry(mask).or_insert(0) += 1;
                }
            }
        }

        let mut result = 0;

        for mask in 0..(1 << 10) {
            let mut subsets = 1;
            for i in 0..10 {
                if (mask & (1 << i)) != 0 {
                    subsets *= count.get(&(1 << i)).unwrap_or(&0) + 1;
                }
            }
            if mask > 0 {
                result += subsets;
            }
        }

        (result * total_ones) % 1_000_000_007
    }
}