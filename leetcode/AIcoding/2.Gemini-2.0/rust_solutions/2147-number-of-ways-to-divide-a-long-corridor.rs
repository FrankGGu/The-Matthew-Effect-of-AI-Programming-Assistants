impl Solution {
    pub fn number_of_ways(corridor: String) -> i32 {
        let n = corridor.len();
        let mut seats = 0;
        let mut plants = 0;
        let mut last_seat = -1;
        let mut ans = 1;
        let MOD = 1_000_000_007;

        for (i, c) in corridor.chars().enumerate() {
            if c == 'S' {
                seats += 1;
                if seats > 2 && seats % 2 == 1 {
                    ans = (ans * (i as i64 - last_seat as i64)) % MOD;
                }
                last_seat = i as i32;
            }
        }

        if seats < 2 || seats % 2 == 1 {
            return 0;
        }

        ans as i32
    }
}