struct Solution;

impl Solution {
    pub fn purchase_scheme(mut prices: Vec<i32>, budget: i32) -> i32 {
        prices.sort_unstable();

        let mut count = 0;
        let mut left = 0;
        let mut right = prices.len() as i32 - 1;

        while left < right {
            if prices[left as usize] + prices[right as usize] <= budget {
                // If prices[left] + prices[right] is within budget,
                // then prices[left] can be paired with prices[right], prices[right-1], ..., prices[left+1].
                // The number of such elements is (right - (left + 1) + 1) = right - left.
                count += right - left;
                left += 1;
            } else {
                // If prices[left] + prices[right] exceeds budget,
                // prices[right] is too expensive. Try a smaller item.
                right -= 1;
            }
        }

        count
    }
}