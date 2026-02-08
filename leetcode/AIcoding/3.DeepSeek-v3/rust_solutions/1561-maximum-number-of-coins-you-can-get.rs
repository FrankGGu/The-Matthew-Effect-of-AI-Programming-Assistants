impl Solution {
    pub fn max_coins(piles: Vec<i32>) -> i32 {
        let mut piles = piles;
        piles.sort_unstable();
        let n = piles.len();
        let mut res = 0;
        for i in (n / 3..n).step_by(2) {
            res += piles[i];
        }
        res
    }
}