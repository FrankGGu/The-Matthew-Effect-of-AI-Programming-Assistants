impl Solution {
    pub fn find_kth_number(n: i32, k: i32) -> i32 {
        let mut curr: i64 = 1;
        let mut k = k as i64;

        while k > 1 {
            let steps = Solution::get_steps(curr, n as i64);
            if steps >= k {
                curr *= 10;
                k -= 1;
            } else {
                curr += 1;
                k -= steps;
            }
        }

        curr as i32
    }

    fn get_steps(curr: i64, n: i64) -> i64 {
        let mut steps: i64 = 0;
        let mut first: i64 = curr;
        let mut last: i64 = curr + 1;

        while first <= n {
            steps += std::cmp::min(n + 1, last) - first;
            first *= 10;
            last *= 10;
        }

        steps
    }
}