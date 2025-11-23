impl Solution {
    pub fn final_prices(prices: Vec<i32>) -> Vec<i32> {
        let n = prices.len();
        let mut result = prices.clone();
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while let Some(&top_idx) = stack.last() {
                if prices[top_idx] >= prices[i] {
                    result[top_idx] = prices[top_idx] - prices[i];
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        result
    }
}