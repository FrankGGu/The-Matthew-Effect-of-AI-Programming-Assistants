impl Solution {
    pub fn maximum_beauty(flowers: Vec<i32>, new_flowers: i64, target: i32, full: i32, partial: i32) -> i64 {
        let mut flowers = flowers;
        flowers.sort();
        let n = flowers.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + flowers[i] as i64;
        }

        let mut ans = 0;
        for num_full in 0..=n {
            let mut remaining_flowers = new_flowers;
            let mut current_beauty = num_full as i64 * full as i64;

            if num_full > 0 {
                for i in n - num_full..n {
                    remaining_flowers -= (target as i64 - flowers[i] as i64).max(0);
                    if remaining_flowers < 0 {
                        current_beauty = 0;
                        break;
                    }
                }
            }

            if current_beauty == 0 {
                continue;
            }

            let remaining_gardens = n - num_full;

            if remaining_gardens == 0 {
                ans = ans.max(current_beauty);
                continue;
            }

            let mut low = 0;
            let mut high = target as i64 - 1;
            let mut best_partial = 0;

            while low <= high {
                let mid = low + (high - low) / 2;
                let mut needed_flowers = 0;
                for i in 0..remaining_gardens {
                    needed_flowers += (mid - flowers[i] as i64).max(0);
                }

                if needed_flowers <= remaining_flowers {
                    best_partial = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            current_beauty += best_partial * partial as i64;
            ans = ans.max(current_beauty);
        }

        ans
    }
}