impl Solution {
    pub fn max_candies(candies: Vec<i32>, k: i32) -> i32 {
        let (mut left, mut right) = (1, *candies.iter().max().unwrap());
        while left < right {
            let mid = left + (right - left + 1) / 2;
            if candies.iter().map(|&c| c / mid).sum::<i32>() >= k {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        left
    }
}