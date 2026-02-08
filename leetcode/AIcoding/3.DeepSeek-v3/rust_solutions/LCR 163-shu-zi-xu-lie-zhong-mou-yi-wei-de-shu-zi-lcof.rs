impl Solution {
    pub fn find_kth_number(n: i32, k: i32) -> i32 {
        let mut k = k as i64;
        let mut curr = 1;
        k -= 1;
        while k > 0 {
            let steps = Self::count_steps(n as i64, curr as i64, curr as i64 + 1);
            if steps <= k {
                curr += 1;
                k -= steps;
            } else {
                curr *= 10;
                k -= 1;
            }
        }
        curr as i32
    }

    fn count_steps(n: i64, mut curr: i64, mut next: i64) -> i64 {
        let mut steps = 0;
        while curr <= n {
            steps += std::cmp::min(n + 1, next) - curr;
            curr *= 10;
            next *= 10;
        }
        steps
    }
}