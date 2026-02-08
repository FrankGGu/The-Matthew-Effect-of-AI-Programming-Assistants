impl Solution {
    pub fn minimum_cost(s: String, target: String) -> i32 {
        let s_bytes = s.as_bytes();
        let target_bytes = target.as_bytes();
        let mut cost = 0;

        for (a, b) in s_bytes.iter().zip(target_bytes.iter()) {
            if a != b {
                cost += 1;
            }
        }

        cost
    }
}