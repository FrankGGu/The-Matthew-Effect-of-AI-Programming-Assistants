impl Solution {
    pub fn max_run_time(n: i32, batteries: Vec<i32>) -> i64 {
        let mut left = 0i64;
        let mut right = batteries.iter().map(|&x| x as i64).sum::<i64>() / n as i64;
        let mut answer = 0;
        while left <= right {
            let mid = left + (right - left) / 2;
            let total: i64 = batteries.iter().map(|&x| std::cmp::min(x as i64, mid)).sum();
            if total >= mid * n as i64 {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        answer
    }
}