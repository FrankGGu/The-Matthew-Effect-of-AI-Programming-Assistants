impl Solution {
    pub fn get_maximum_consecutive(mut coins: Vec<i32>) -> i32 {
        coins.sort_unstable();

        let mut reachable_max: i64 = 0;

        for coin_val in coins {
            let coin = coin_val as i64;

            if coin > reachable_max + 1 {
                break;
            }

            reachable_max += coin;
        }

        (reachable_max + 1) as i32
    }
}