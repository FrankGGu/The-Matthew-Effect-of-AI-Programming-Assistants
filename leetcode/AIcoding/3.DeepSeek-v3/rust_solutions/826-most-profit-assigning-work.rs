use std::cmp;

impl Solution {
    pub fn max_profit_assignment(difficulty: Vec<i32>, profit: Vec<i32>, worker: Vec<i32>) -> i32 {
        let mut jobs: Vec<(i32, i32)> = difficulty.into_iter().zip(profit.into_iter()).collect();
        jobs.sort();

        let mut max_profit_up_to = vec![0; jobs.len()];
        max_profit_up_to[0] = jobs[0].1;
        for i in 1..jobs.len() {
            max_profit_up_to[i] = cmp::max(max_profit_up_to[i - 1], jobs[i].1);
        }

        let mut total = 0;
        for &ability in &worker {
            let idx = match jobs.binary_search_by_key(&ability, |&(d, _)| d) {
                Ok(i) => i,
                Err(i) => if i == 0 { continue; } else { i - 1 },
            };
            total += max_profit_up_to[idx];
        }

        total
    }
}