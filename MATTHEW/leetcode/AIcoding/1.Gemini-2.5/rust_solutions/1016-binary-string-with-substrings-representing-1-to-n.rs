impl Solution {
    pub fn query_string(s: String, n: i32) -> bool {
        if n > s.len() as i32 * 2 + 100 { // A common heuristic bound for N
            return false;
        }

        for i in 1..=n {
            let bin_i = format!("{:b}", i);
            if !s.contains(&bin_i) {
                return false;
            }
        }
        true
    }
}