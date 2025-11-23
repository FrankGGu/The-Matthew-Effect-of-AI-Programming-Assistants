impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_factor_score(nums: Vec<i32>) -> i64 {
        let mut max_score = 0;
        let mut max_index = 0;

        for (i, &num) in nums.iter().enumerate() {
            let score = factor_score(num);
            match score.cmp(&max_score) {
                Ordering::Greater => {
                    max_score = score;
                    max_index = i;
                },
                Ordering::Equal => {
                    if i < max_index {
                        max_index = i;
                    }
                },
                _ => {}
            }
        }

        max_index as i64
    }
}

fn factor_score(n: i32) -> i64 {
    let n = n.abs();
    let mut score = 1;
    let mut i = 2;
    while i * i <= n {
        let mut count = 0;
        while n % i == 0 {
            count += 1;
            n /= i;
        }
        if count > 0 {
            score *= (i as i64).pow(count as u32);
        }
        i += 1;
    }
    if n > 1 {
        score *= n as i64;
    }
    score
}
}