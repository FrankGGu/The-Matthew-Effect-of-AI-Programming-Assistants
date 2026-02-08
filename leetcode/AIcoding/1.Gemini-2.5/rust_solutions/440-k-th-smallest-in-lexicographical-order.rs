struct Solution;

impl Solution {
    pub fn find_kth_number(n: i32, k: i32) -> i32 {
        let mut k = k - 1;
        let mut curr = 1;

        while k > 0 {
            let mut steps = 0;
            let mut first = curr;
            let mut last = curr + 1;

            while first <= n {
                steps += (n + 1).min(last) - first;
                first *= 10;
                last *= 10;
            }

            if k >= steps {
                curr += 1;
                k -= steps;
            } else {
                curr *= 10;
                k -= 1;
            }
        }
        curr
    }
}