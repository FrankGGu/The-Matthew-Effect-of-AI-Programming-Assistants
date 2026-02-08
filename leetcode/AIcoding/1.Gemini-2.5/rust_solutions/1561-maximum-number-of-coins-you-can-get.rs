impl Solution {
    pub fn max_coins(mut piles: Vec<i32>) -> i32 {
        piles.sort();
        let mut my_coins = 0;
        let mut left = 0;
        let mut right = piles.len() - 1;

        while left < right {
            // Alice takes piles[right] (the largest remaining)
            // We take piles[right - 1] (the second largest remaining)
            my_coins += piles[right - 1];
            // Bob takes piles[left] (the smallest remaining)

            left += 1;
            right -= 2;
        }

        my_coins
    }
}