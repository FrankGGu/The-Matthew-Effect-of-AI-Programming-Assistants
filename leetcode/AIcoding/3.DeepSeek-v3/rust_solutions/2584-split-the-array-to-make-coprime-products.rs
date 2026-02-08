use std::collections::HashMap;

impl Solution {
    pub fn find_valid_split(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = HashMap::new();
        let mut right = HashMap::new();

        for &num in &nums {
            let mut x = num;
            let mut factors = HashMap::new();
            for d in 2..=((x as f64).sqrt() as i32) {
                while x % d == 0 {
                    *factors.entry(d).or_insert(0) += 1;
                    x /= d;
                }
            }
            if x > 1 {
                *factors.entry(x).or_insert(0) += 1;
            }
            for (&p, &cnt) in &factors {
                *right.entry(p).or_insert(0) += cnt;
            }
        }

        let mut common = 0;
        for i in 0..n-1 {
            let mut x = nums[i];
            let mut factors = HashMap::new();
            for d in 2..=((x as f64).sqrt() as i32) {
                while x % d == 0 {
                    *factors.entry(d).or_insert(0) += 1;
                    x /= d;
                }
            }
            if x > 1 {
                *factors.entry(x).or_insert(0) += 1;
            }
            for (&p, &cnt) in &factors {
                let total = *right.get(&p).unwrap_or(&0);
                let left_cnt = *left.get(&p).unwrap_or(&0);
                if left_cnt == 0 && total > left_cnt {
                    common += 1;
                }
                *left.entry(p).or_insert(0) += cnt;
                if *left.get(&p).unwrap_or(&0) == total {
                    common -= 1;
                }
            }
            if common == 0 {
                return i as i32;
            }
        }

        -1
    }
}