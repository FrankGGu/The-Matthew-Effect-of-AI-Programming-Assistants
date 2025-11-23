impl Solution {
    pub fn min_operations(target: Vec<i32>, arr: Vec<i32>) -> i32 {
        use std::collections::HashSet;
        use std::cmp::Ordering;

        let target_set: HashSet<i32> = target.iter().cloned().collect();
        let lis: Vec<i32> = arr.iter()
            .filter(|&&x| target_set.contains(&x))
            .collect();

        let mut dp = vec![];

        for &num in &lis {
            match dp.binary_search(&num) {
                Ok(_) => continue,
                Err(pos) => {
                    if pos < dp.len() {
                        dp[pos] = num;
                    } else {
                        dp.push(num);
                    }
                }
            }
        }

        target.len() as i32 - dp.len() as i32
    }
}