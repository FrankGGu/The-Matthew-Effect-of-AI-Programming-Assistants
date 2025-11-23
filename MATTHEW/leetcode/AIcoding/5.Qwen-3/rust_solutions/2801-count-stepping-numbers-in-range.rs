impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_stepping_numbers(low: i64, high: i64) -> i64 {
        let mut result = HashSet::new();
        for i in 0..10 {
            dfs(i, low, high, &mut result);
        }
        result.into_iter().filter(|&x| x >= low && x <= high).count() as i64
    }
}

fn dfs(num: i64, low: i64, high: i64, result: &mut HashSet<i64>) {
    if num > high {
        return;
    }
    if num >= low {
        result.insert(num);
    }
    let last_digit = num % 10;
    for next_digit in 0..10 {
        if (next_digit - last_digit).abs() == 1 {
            let new_num = num * 10 + next_digit;
            dfs(new_num, low, high, result);
        }
    }
}
}