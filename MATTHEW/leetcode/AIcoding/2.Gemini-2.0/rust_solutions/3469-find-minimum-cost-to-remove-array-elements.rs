impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut pairs: Vec<_> = nums.iter().zip(cost.iter()).collect();
        pairs.sort();

        let mut total_sum: i64 = cost.iter().map(|&x| x as i64).sum();
        let mut current_sum: i64 = 0;
        let mut median_value: i32 = 0;

        for i in 0..n {
            current_sum += *pairs[i].1 as i64;
            if current_sum * 2 >= total_sum {
                median_value = *pairs[i].0;
                break;
            }
        }

        let mut result: i64 = 0;
        for i in 0..n {
            result += (*pairs[i].0 as i64 - median_value as i64).abs() * *pairs[i].1 as i64;
        }

        result
    }
}