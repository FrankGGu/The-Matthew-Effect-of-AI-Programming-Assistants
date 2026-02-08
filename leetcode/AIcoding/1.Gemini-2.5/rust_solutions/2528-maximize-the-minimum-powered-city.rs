impl Solution {
    pub fn maximize_the_minimum_powered_city(cities: Vec<i32>, r: i64, k: i64) -> i64 {
        let n = cities.len();

        let mut low = 0i64;
        let mut high = 2_000_000_000_000_000i64; // A sufficiently large upper bound (max_city_power + k*r)
        let mut ans = 0i64;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &cities, r, k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn check(target_min_power: i64, cities: &[i32], r: i64, k: i64) -> bool {
        let n = cities.len();

        let mut prefix_sums = vec![0i64; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + cities[i] as i64;
        }

        let mut initial_power = vec![0i64; n];
        for i in 0..n {
            let left_bound = (i as i64 - r).max(0) as usize;
            let right_bound = (i as i64 + r).min(n as i64 - 1) as usize;
            initial_power[i] = prefix_sums[right_bound + 1] - prefix_sums[left_bound];
        }

        let mut num_stations_used = 0i64;
        let mut diff_effect = vec![0i64; n + 1]; 
        let mut current_effective_added_power = 0i64; 

        for i in 0..n {
            current_effective_added_power += diff_effect[i];

            let current_total_power = initial_power[i] + current_effective_added_power;

            if current_total_power < target_min_power {
                let needed = target_min_power - current_total_power;
                num_stations_used += needed;

                if num_stations_used > k {
                    return false; 
                }

                let station_j = (i as i64 + r).min(n as i64 - 1) as usize;
                current_effective_added_power += needed;

                let effect_end_city_idx = (station_j as i64 + r).min(n as i64 - 1) as usize;
                let diff_effect_end_idx = effect_end_city_idx + 1;
                if diff_effect_end_idx <= n {
                    diff_effect[diff_effect_end_idx] -= needed;
                }
            }
        }

        true
    }
}