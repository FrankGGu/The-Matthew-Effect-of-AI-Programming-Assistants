use std::collections::HashMap;

impl Solution {
    pub fn max_happy_groups(batch_size: i32, groups: Vec<i32>) -> i32 {
        let batch_size = batch_size as usize;
        let mut count = vec![0; batch_size];
        for &g in &groups {
            count[(g as usize % batch_size)] += 1;
        }
        let mut memo = HashMap::new();
        Self::dfs(&mut count, 0, batch_size, &mut memo) + count[0]
    }

    fn dfs(count: &mut Vec<i32>, left: usize, batch_size: usize, memo: &mut HashMap<Vec<i32>, i32>) -> i32 {
        if let Some(&res) = memo.get(count) {
            return res;
        }
        let mut res = 0;
        for i in 1..batch_size {
            if count[i] == 0 {
                continue;
            }
            count[i] -= 1;
            let new_left = (left + batch_size - i) % batch_size;
            let current = if new_left == 0 { 1 } else { 0 };
            res = res.max(current + Self::dfs(count, new_left, batch_size, memo));
            count[i] += 1;
        }
        memo.insert(count.clone(), res);
        res
    }
}