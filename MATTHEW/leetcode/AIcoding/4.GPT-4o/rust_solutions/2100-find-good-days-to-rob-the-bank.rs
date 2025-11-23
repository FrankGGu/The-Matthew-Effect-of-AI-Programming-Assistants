impl Solution {
    pub fn good_days_to_rob_bank(security: Vec<i32>, time: i32) -> Vec<i32> {
        let n = security.len();
        let mut non_increasing = vec![0; n];
        let mut result = Vec::new();

        for i in (1..n).rev() {
            if security[i] <= security[i - 1] {
                non_increasing[i - 1] = non_increasing[i] + 1;
            }
        }

        for i in time as usize..n - time as usize {
            if non_increasing[i] >= time {
                result.push(i as i32);
            }
        }

        result
    }
}