impl Solution {
    pub fn put_marbles(weights: Vec<i32>, k: i32) -> i32 {
        let mut pairs: Vec<i32> = Vec::new();

        for i in 0..weights.len() - 1 {
            pairs.push(weights[i] + weights[i + 1]);
        }

        pairs.sort();

        let max_sum: i32 = pairs.iter().rev().take((k - 1) as usize).sum();
        let min_sum: i32 = pairs.iter().take((k - 1) as usize).sum();

        max_sum - min_sum
    }
}