impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let mut pairs: Vec<(i32, i32)> = nums.iter().zip(cost.iter()).map(|(&n, &c)| (n, c)).collect();
        pairs.sort();

        let mut total_cost: i64 = 0;
        let mut total_sum: i64 = 0;

        for i in 0..pairs.len() {
            total_sum += pairs[i].1 as i64;
        }

        let mut current_sum: i64 = 0;
        let mut median: i32 = pairs[0].0;

        for i in 0..pairs.len() {
            current_sum += pairs[i].1 as i64;
            if current_sum * 2 >= total_sum {
                median = pairs[i].0;
                break;
            }
        }

        for i in 0..pairs.len() {
            total_cost += (pairs[i].0 as i64 - median as i64).abs() * pairs[i].1 as i64;
        }

        total_cost
    }
}