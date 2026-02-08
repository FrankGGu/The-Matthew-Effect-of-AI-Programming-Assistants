impl Solution {
    pub fn ways_to_purchase_items(n: i32, price: Vec<i32>, quantity: Vec<i32>) -> i32 {
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;

        for (p, q) in price.iter().zip(quantity.iter()) {
            for j in (0..=n).rev() {
                for k in 1..=q {
                    if j >= k * p {
                        dp[j as usize] = (dp[j as usize] + dp[(j - k * p) as usize]) % 1_000_000_007;
                    } else {
                        break;
                    }
                }
            }
        }

        dp[n as usize]
    }
}