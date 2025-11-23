impl Solution {
    pub fn minimum_number_of_coins(coins: Vec<i32>, target: i32) -> i32 {
        let mut coins = coins;
        coins.sort();
        let mut added = 0;
        let mut current_max = 0;
        for &coin in &coins {
            if coin > current_max + 1 {
                added += 1;
                current_max += current_max + 1;
                while coin > current_max + 1 {
                    added += 1;
                    current_max += current_max + 1;
                }
            }
            current_max = current_max.max(coin);
        }
        while target > current_max {
            added += 1;
            current_max += current_max + 1;
        }
        added
    }
}