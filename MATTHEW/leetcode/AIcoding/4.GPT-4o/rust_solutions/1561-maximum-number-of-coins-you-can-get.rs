impl Solution {
    pub fn max_coins(piles: Vec<i32>) -> i32 {
        let mut piles = piles;
        piles.sort();
        let n = piles.len() / 3;
        let mut max_coins = 0;

        for i in (n..piles.len() - n).step_by(2) {
            max_coins += piles[i];
        }

        max_coins
    }
}