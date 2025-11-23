impl Solution {
    pub fn put_marbles(weights: Vec<i32>, k: i32) -> i64 {
        let n = weights.len();
        let mut pairs: Vec<i32> = Vec::with_capacity(n - 1);
        for i in 0..(n - 1) {
            pairs.push(weights[i] + weights[i + 1]);
        }
        pairs.sort();
        let mut min_sum: i64 = 0;
        let mut max_sum: i64 = 0;
        for i in 0..(k as usize - 1) {
            min_sum += pairs[i] as i64;
            max_sum += pairs[n - 2 - i] as i64;
        }
        max_sum - min_sum
    }
}