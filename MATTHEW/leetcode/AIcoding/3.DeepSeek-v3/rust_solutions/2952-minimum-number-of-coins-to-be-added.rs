impl Solution {
    pub fn minimum_added_coins(coins: Vec<i32>, target: i32) -> i32 {
        let mut coins = coins;
        coins.sort_unstable();
        let mut res = 0;
        let mut max_reach = 0;
        let mut i = 0;
        while max_reach < target {
            if i < coins.len() && coins[i] <= max_reach + 1 {
                max_reach += coins[i];
                i += 1;
            } else {
                res += 1;
                max_reach += max_reach + 1;
            }
        }
        res
    }
}