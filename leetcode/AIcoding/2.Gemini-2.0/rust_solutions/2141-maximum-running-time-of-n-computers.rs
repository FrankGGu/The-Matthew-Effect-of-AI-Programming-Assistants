impl Solution {
    pub fn max_run_time(n: i32, batteries: Vec<i32>) -> i64 {
        let mut batteries = batteries;
        batteries.sort();
        let mut sum: i64 = batteries.iter().map(|&x| x as i64).sum();
        let mut i = batteries.len() - 1;
        while i >= 0 {
            let battery = batteries[i];
            if battery as i64 > sum / n as i64 {
                sum -= battery as i64;
                n -= 1;
                i -= 1;
            } else {
                break;
            }
            if n == 0 {
                return 0;
            }
        }
        sum / n as i64
    }
}