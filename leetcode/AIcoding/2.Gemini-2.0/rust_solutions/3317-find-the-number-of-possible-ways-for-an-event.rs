impl Solution {
    pub fn number_of_ways(corridor: String) -> i32 {
        let n = corridor.len();
        let mut seats = 0;
        let mut plants = 0;
        let mut prev_seat_index = -1;
        let mut count = 1;
        let MOD = 1_000_000_007;

        for (i, c) in corridor.chars().enumerate() {
            if c == 'S' {
                seats += 1;
                if seats > 2 && seats % 2 == 1 {
                    plants = i as i32 - prev_seat_index as i32;
                    count = (count * plants) % MOD;
                }
                prev_seat_index = i as i32;
            }
        }

        if seats % 2 != 0 || seats == 0 {
            return 0;
        }

        count as i32
    }
}