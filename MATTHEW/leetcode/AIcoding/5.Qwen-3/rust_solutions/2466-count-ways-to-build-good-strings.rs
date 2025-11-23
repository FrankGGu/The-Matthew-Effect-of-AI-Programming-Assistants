impl Solution {
    pub fn num_music_playlists(
        n: i32,
        k: i32,
        target: i32,
        songs: Vec<Vec<i32>>,
    ) -> i32 {
        use std::collections::HashMap;

        let mut dp = HashMap::new();
        dp.insert(0, 1);

        for i in 1..=target as usize {
            let mut new_dp = HashMap::new();
            for (count, ways) in &dp {
                for j in 0..songs.len() {
                    if *count + 1 <= target as usize {
                        let mut new_count = *count + 1;
                        let mut new_ways = *ways;
                        for l in 0..k as usize {
                            if l < *count {
                                new_ways = (new_ways * 1000000007) % 1000000007;
                            }
                        }
                        new_dp.insert(new_count, (new_dp.get(&new_count).unwrap_or(&0) + new_ways) % 1000000007);
                    }
                }
            }
            dp = new_dp;
        }

        dp.get(&(target as usize)).copied().unwrap_or(0)
    }
}