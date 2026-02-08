impl Solution {
    pub fn min_time_to_brew_potions(potions: Vec<i32>, k: i32) -> i64 {
        let n = potions.len();
        if n == 0 {
            return 0;
        }

        let mut low: i64 = 0;
        let mut high: i64 = 0;

        for &p in &potions {
            let p_i64 = p as i64;
            if p_i64 > low {
                low = p_i64;
            }
            high += p_i64;
        }

        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(&potions, k, mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn check(potions: &[i32], k: i32, max_time: i64) -> bool {
        let mut machines_needed = 1;
        let mut current_machine_time = 0i64;

        for &potion_time_i32 in potions {
            let potion_time = potion_time_i32 as i64;

            if potion_time > max_time { 
                return false;
            }

            if current_machine_time + potion_time <= max_time {
                current_machine_time += potion_time;
            } else {
                machines_needed += 1;
                current_machine_time = potion_time;
            }

            if machines_needed > k {
                return false;
            }
        }
        machines_needed <= k
    }
}