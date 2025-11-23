impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_probability(nums: Vec<i32>) -> f64 {
        let total = nums.iter().map(|&x| x as usize).sum::<usize>();
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        let mut memo = HashMap::new();
        dfs(&count, 0, 0, 0, 0, &mut memo)
    }
}

fn dfs(
    count: &HashMap<i32, usize>,
    index: usize,
    left: usize,
    right: usize,
    distinct_left: usize,
    memo: &mut HashMap<(usize, usize, usize), f64>,
) -> f64 {
    if index == count.len() {
        return if left == right { 1.0 } else { 0.0 };
    }
    let key = (index, left, right);
    if let Some(&val) = memo.get(&key) {
        return val;
    }
    let mut res = 0.0;
    let (num, freq) = count.iter().nth(index).unwrap();
    let total = count.values().sum::<usize>();
    let mut temp = 0;
    for take in 0..=*freq {
        let remaining = freq - take;
        let new_left = left + take;
        let new_right = right + remaining;
        let new_distinct_left = if take > 0 { distinct_left + 1 } else { distinct_left };
        res += dfs(count, index + 1, new_left, new_right, new_distinct_left, memo);
    }
    memo.insert(key, res);
    res
}
}