impl Solution {
    pub fn max_coins(piles: Vec<i32>) -> i32 {
        let mut piles = piles;
        piles.sort();
        let mut ans = 0;
        let n = piles.len();
        for i in (0..n / 3).rev() {
            ans += piles[2 * i + 1];
        }
        ans
    }
}