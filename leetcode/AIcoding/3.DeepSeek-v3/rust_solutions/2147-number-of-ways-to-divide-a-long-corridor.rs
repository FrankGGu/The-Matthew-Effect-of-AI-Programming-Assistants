impl Solution {
    pub fn number_of_ways(corridor: String) -> i32 {
        let mut seats = 0;
        let mut plants = 0;
        let mut ways = 1i64;
        let mod_val = 1_000_000_007i64;

        for c in corridor.chars() {
            if c == 'S' {
                seats += 1;
                if seats > 2 && seats % 2 == 1 {
                    ways = (ways * (plants + 1)) % mod_val;
                }
                plants = 0;
            } else if seats >= 2 && seats % 2 == 0 {
                plants += 1;
            }
        }

        if seats < 2 || seats % 2 != 0 {
            return 0;
        }

        ways as i32
    }
}