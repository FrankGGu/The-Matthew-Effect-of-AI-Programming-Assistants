impl Solution {
    pub fn find_stable_mountain_indices(mountains: Vec<Vec<i32>>) -> Vec<i32> {
        let mut res = Vec::new();
        for (i, m) in mountains.iter().enumerate() {
            let n = m.len();
            if n < 3 {
                continue;
            }
            let mut peak = 0;
            while peak + 1 < n && m[peak] < m[peak + 1] {
                peak += 1;
            }
            if peak == 0 || peak == n - 1 {
                continue;
            }
            let mut left = peak;
            while left > 0 && m[left - 1] > m[left] {
                left -= 1;
            }
            let mut right = peak;
            while right + 1 < n && m[right + 1] < m[right] {
                right += 1;
            }
            if left == 0 && right == n - 1 {
                res.push(i as i32);
            }
        }
        res
    }
}