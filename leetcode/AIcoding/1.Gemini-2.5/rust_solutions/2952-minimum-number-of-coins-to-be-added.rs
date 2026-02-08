impl Solution {
    pub fn minimum_added_coins(coins: Vec<i32>, target: i32) -> i32 {
        let mut coins = coins;
        coins.sort_unstable();

        let mut added_coins = 0;
        let mut reach: i32 = 0;
        let mut i = 0;

        while reach < target {
            if i < coins.len() && coins[i] <= reach + 1 {
                reach += coins[i];
                i += 1;
            } else {
                reach += (reach + 1);
                added_coins += 1;
            }
        }

        added_coins
    }
}