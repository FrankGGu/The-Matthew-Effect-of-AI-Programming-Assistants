impl Solution {
    pub fn max_score(card_points: Vec<i32>, k: i32) -> i32 {
        let n = card_points.len();
        let k = k as usize;
        let mut sum: i32 = card_points[0..k].iter().sum();
        let mut max_sum = sum;

        for i in 0..k {
            sum = sum - card_points[k - 1 - i] + card_points[n - 1 - i];
            max_sum = max_sum.max(sum);
        }

        max_sum
    }
}