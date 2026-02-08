impl Solution {
    pub fn find_kth_number(n: i32, k: i32) -> i32 {
        let mut curr = 1;
        let mut k = k - 1;
        while k > 0 {
            let steps = Self::calculate_steps(n as i64, curr as i64, (curr + 1) as i64);
            if steps <= k as i64 {
                curr += 1;
                k -= steps as i32;
            } else {
                curr *= 10;
                k -= 1;
            }
        }
        curr
    }

    fn calculate_steps(n: i64, n1: i64, n2: i64) -> i64 {
        let mut steps = 0;
        let mut n1 = n1;
        let mut n2 = n2;
        while n1 <= n {
            steps += std::cmp::min(n + 1, n2) - n1;
            n1 *= 10;
            n2 *= 10;
        }
        steps
    }
}