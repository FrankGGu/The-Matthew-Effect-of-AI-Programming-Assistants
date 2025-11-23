impl Solution {
    pub fn max_power(stations: Vec<i32>, r: i32, k: i64) -> i64 {
        let n = stations.len();
        let mut l = 0;
        let mut h = 10i64.pow(10);
        let mut ans = 0;

        while l <= h {
            let mid = l + (h - l) / 2;
            if Self::is_possible(&stations, r, k, mid) {
                ans = mid;
                l = mid + 1;
            } else {
                h = mid - 1;
            }
        }

        ans
    }

    fn is_possible(stations: &Vec<i32>, r: i32, k: i64, target: i64) -> bool {
        let n = stations.len();
        let mut current_power: Vec<i64> = vec![0; n];
        let mut additional_k = k;
        let mut current_sum: i64 = 0;

        for i in 0..n {
            current_sum += if i > 0 { current_power[i - 1] } else { 0 };

            let needed = target - current_sum;
            if needed > 0 {
                if additional_k >= needed {
                    additional_k -= needed;
                    current_power[i] = needed;
                    current_sum += needed;
                } else {
                    return false;
                }
            }

            let station_power = stations[i] as i64;
            let start = std::cmp::max(0, i as i32 - r) as usize;
            let end = std::cmp::min(n - 1, i as i32 + r) as usize;

            if i + 1 < n {
                current_power[i] -= if start > 0 { current_power[start - 1]} else {0};
                if end + 1 < n {
                    current_power[end] += current_power[i];
                }
            }

            current_sum -= if start > 0 { current_power[start - 1] } else { 0 } ;
             if i + 1 < n {
                  current_power[i] = current_power[i] + station_power;
             }

           if i < n {
                current_sum += station_power;
             }

           if i + 1 < n {
                current_power[i] -= if start > 0 { current_power[start - 1]} else {0};
            }
        }

        true
    }
}