impl Solution {

use std::cmp;

impl Solution {
    pub fn max_gcd_length(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut max_len = 0;
        let mut max_gcd = 0;

        for (&a, &count_a) in &freq {
            if count_a < k {
                continue;
            }
            for (&b, &count_b) in &freq {
                if a == b {
                    if count_a >= k {
                        max_len = cmp::max(max_len, k);
                        max_gcd = cmp::max(max_gcd, a);
                    }
                } else {
                    let g = gcd(a, b);
                    if count_a >= 1 && count_b >= 1 {
                        let mut total = 1;
                        let mut a_count = count_a;
                        let mut b_count = count_b;
                        while a_count > 0 && b_count > 0 {
                            a_count -= 1;
                            b_count -= 1;
                            total += 1;
                        }
                        if total >= k {
                            max_len = cmp::max(max_len, total);
                            max_gcd = cmp::max(max_gcd, g);
                        }
                    }
                }
            }
        }

        if max_len >= k {
            max_gcd
        } else {
            0
        }
    }
}

fn gcd(mut a: i32, mut b: i32) -> i32 {
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a.abs()
}
}