impl Solution {

use std::collections::HashMap;

fn max_divisibility_score(nums: Vec<i32>, divisors: Vec<i32>) -> i32 {
    let mut score_map = HashMap::new();
    let mut max_score = 0;
    let mut result = divisors[0];

    for &d in &divisors {
        let mut score = 0;
        for &n in &nums {
            if n % d == 0 {
                score += 1;
            }
        }
        score_map.insert(d, score);
        if score > max_score || (score == max_score && d < result) {
            max_score = score;
            result = d;
        }
    }

    result
}

pub fn main() {
    // Example usage:
    // let nums = vec![4, 7, 3, 9, 12];
    // let divisors = vec![3, 4, 12];
    // println!("{}", max_divisibility_score(nums, divisors));
}
}