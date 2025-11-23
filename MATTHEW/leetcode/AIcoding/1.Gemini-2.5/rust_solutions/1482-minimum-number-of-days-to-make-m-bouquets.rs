impl Solution {
    pub fn min_days(bloom_day: Vec<i32>, m: i32, k: i32) -> i32 {
        let n = bloom_day.len();

        if (m as i64) * (k as i64) > n as i64 {
            return -1;
        }

        let mut low = 1;
        let mut high = *bloom_day.iter().max().unwrap(); // The maximum bloom day is the upper bound for our search

        let mut ans = -1;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_make_bouquets(mid, &bloom_day, m, k) {
                ans = mid;
                high = mid - 1; // Try to find an even smaller day
            } else {
                low = mid + 1; // Need more days
            }
        }

        ans
    }

    fn can_make_bouquets(days: i32, bloom_day: &[i32], m: i32, k: i32) -> bool {
        let mut num_bouquets = 0;
        let mut current_adjacent_flowers = 0;

        for &flower_bloom_day in bloom_day.iter() {
            if flower_bloom_day <= days {
                current_adjacent_flowers += 1;
                if current_adjacent_flowers == k {
                    num_bouquets += 1;
                    current_adjacent_flowers = 0; // Reset for the next bouquet
                }
            } else {
                current_adjacent_flowers = 0; // Adjacency is broken if a flower hasn't bloomed
            }
        }
        num_bouquets >= m
    }
}