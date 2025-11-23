impl Solution {
    pub fn min_increments(n: i32, cost: Vec<i32>) -> i32 {
        let mut cost = cost;
        let mut ans = 0;
        for i in (0..(n - 1) / 2).rev() {
            let left = cost[(2 * i + 1) as usize];
            let right = cost[(2 * i + 2) as usize];
            ans += (left - right).abs();
            cost[i as usize] += std::cmp::max(left, right);
        }
        ans
    }
}