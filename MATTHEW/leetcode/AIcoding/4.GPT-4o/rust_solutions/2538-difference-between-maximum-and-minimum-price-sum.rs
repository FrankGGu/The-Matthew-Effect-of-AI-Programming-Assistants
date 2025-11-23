pub fn max_difference(prices: Vec<i32>) -> i32 {
    let mut max_sum = 0;
    let mut min_sum = 0;
    let n = prices.len();

    for i in 0..n {
        for j in i+1..n {
            let current_sum = prices[i] + prices[j];
            max_sum = max_sum.max(current_sum);
            min_sum = min_sum.min(current_sum);
        }
    }
    max_sum - min_sum
}