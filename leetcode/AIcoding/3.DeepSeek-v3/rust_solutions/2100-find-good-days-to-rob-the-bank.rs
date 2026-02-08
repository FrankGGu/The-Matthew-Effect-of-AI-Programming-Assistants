impl Solution {
    pub fn good_days_to_rob_bank(security: Vec<i32>, time: i32) -> Vec<i32> {
        let n = security.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 1..n {
            if security[i] <= security[i - 1] {
                left[i] = left[i - 1] + 1;
            }
        }

        for i in (0..n - 1).rev() {
            if security[i] <= security[i + 1] {
                right[i] = right[i + 1] + 1;
            }
        }

        let mut res = Vec::new();
        for i in 0..n {
            if left[i] >= time && right[i] >= time {
                res.push(i as i32);
            }
        }

        res
    }
}