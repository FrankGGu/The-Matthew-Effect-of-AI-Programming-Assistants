impl Solution {
    pub fn count_complete_day_pairs(hours: Vec<i32>) -> i64 {
        let mut remainders: Vec<i64> = vec![0; 24];
        let mut pair_count: i64 = 0;

        for h in hours {
            let r = h % 24;

            let target_remainder = (24 - r) % 24;

            pair_count += remainders[target_remainder as usize];

            remainders[r as usize] += 1;
        }

        pair_count
    }
}