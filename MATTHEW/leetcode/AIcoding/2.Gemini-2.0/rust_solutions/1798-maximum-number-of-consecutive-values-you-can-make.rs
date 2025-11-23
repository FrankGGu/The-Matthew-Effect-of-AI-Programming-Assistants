impl Solution {
    pub fn get_maximum_consecutive(coins: Vec<i32>) -> i32 {
        let mut coins = coins;
        coins.sort();
        let mut reachable = 1;
        for coin in coins {
            if coin > reachable {
                break;
            }
            reachable += coin;
        }
        reachable
    }
}