impl Solution {
    pub fn min_increments(n: i32, cost: Vec<i32>) -> i32 {
        let mut cost = cost;
        let mut res = 0;
        for i in (0..(n as usize) / 2).rev() {
            let left = 2 * i + 1;
            let right = 2 * i + 2;
            res += (cost[left] - cost[right]).abs();
            cost[i] += std::cmp::max(cost[left], cost[right]);
        }
        res
    }
}