impl Solution {
    pub fn max_power(stations: Vec<i32>, r: i32, k: i32) -> i64 {
        let n = stations.len();
        let r = r as usize;
        let k = k as i64;

        let mut prefix = vec![0i64; n + 1];
        for i in 0..n {
            let left = if i >= r { i - r } else { 0 };
            let right = std::cmp::min(i + r, n - 1);
            prefix[left] += stations[i] as i64;
            if right + 1 < n {
                prefix[right + 1] -= stations[i] as i64;
            }
        }

        let mut current = 0i64;
        let mut power = vec![0i64; n];
        for i in 0..n {
            current += prefix[i];
            power[i] = current;
        }

        let mut left = *power.iter().min().unwrap() as i64;
        let mut right = left + k;

        while left < right {
            let mid = (left + right + 1) / 2;
            if Self::is_possible(&power, mid, r, k) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }

    fn is_possible(power: &[i64], min_power: i64, r: usize, k: i64) -> bool {
        let n = power.len();
        let mut diff = vec![0i64; n + 1];
        let mut current = 0i64;
        let mut remaining = k;

        for i in 0..n {
            current += diff[i];
            let total = power[i] + current;
            if total < min_power {
                let needed = min_power - total;
                if needed > remaining {
                    return false;
                }
                remaining -= needed;
                current += needed;
                let end = std::cmp::min(i + 2 * r + 1, n);
                if end < n {
                    diff[end] -= needed;
                }
            }
        }

        true
    }
}