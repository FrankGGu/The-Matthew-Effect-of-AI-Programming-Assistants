impl Solution {
    pub fn find_kth_number(n: i32, k: i32) -> i32 {
        let mut current = 1;
        let mut k = k - 1;

        while k > 0 {
            let mut steps = 0;
            let mut first = current;
            let mut last = current + 1;

            while first <= n {
                steps += std::cmp::min(n + 1, last) - first;
                first *= 10;
                last *= 10;
            }

            if steps <= k {
                current += 1;
                k -= steps;
            } else {
                current *= 10;
                k -= 1;
            }
        }

        current
    }
}