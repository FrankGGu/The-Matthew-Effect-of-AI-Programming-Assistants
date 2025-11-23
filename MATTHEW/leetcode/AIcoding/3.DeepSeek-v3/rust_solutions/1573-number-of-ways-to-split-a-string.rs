impl Solution {
    pub fn num_ways(s: String) -> i32 {
        let s = s.as_bytes();
        let count_ones = s.iter().filter(|&&c| c == b'1').count();
        if count_ones % 3 != 0 {
            return 0;
        }
        let n = s.len();
        if count_ones == 0 {
            return ((n - 1) * (n - 2) / 2 % 1_000_000_007) as i32);
        }
        let target = count_ones / 3;
        let mut ways_first = 0;
        let mut ways_second = 0;
        let mut count = 0;
        for &c in s {
            if c == b'1' {
                count += 1;
            }
            if count == target {
                ways_first += 1;
            } else if count == 2 * target {
                ways_second += 1;
            }
        }
        ((ways_first as i64 * ways_second as i64) % 1_000_000_007) as i32
    }
}