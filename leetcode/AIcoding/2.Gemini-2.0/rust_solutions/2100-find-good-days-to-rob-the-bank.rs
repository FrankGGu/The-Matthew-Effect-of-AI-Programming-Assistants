impl Solution {
    pub fn good_days_to_rob(security: Vec<i32>, time: i32) -> Vec<i32> {
        let n = security.len();
        if time == 0 {
            return (0..n).collect();
        }
        let mut decreasing = vec![0; n];
        let mut increasing = vec![0; n];
        for i in 1..n {
            if security[i] <= security[i - 1] {
                decreasing[i] = decreasing[i - 1] + 1;
            }
            if security[n - 1 - i] <= security[n - i] {
                increasing[n - 1 - i] = increasing[n - i] + 1;
            }
        }
        let mut result = Vec::new();
        for i in 0..n {
            if decreasing[i] >= time && increasing[i] >= time {
                result.push(i as i32);
            }
        }
        result
    }
}