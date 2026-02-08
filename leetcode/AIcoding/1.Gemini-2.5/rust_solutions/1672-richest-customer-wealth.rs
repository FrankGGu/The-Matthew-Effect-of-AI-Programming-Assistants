impl Solution {
    pub fn maximum_wealth(accounts: Vec<Vec<i32>>) -> i32 {
        let mut max_wealth = 0;
        for customer_accounts in accounts {
            let current_wealth: i32 = customer_accounts.iter().sum();
            if current_wealth > max_wealth {
                max_wealth = current_wealth;
            }
        }
        max_wealth
    }
}