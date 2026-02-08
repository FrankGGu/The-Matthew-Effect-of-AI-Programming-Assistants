impl Solution {
    pub fn number_of_ways(corridor: String) -> i32 {
        let n = corridor.len();
        let mut count = 0;
        let mut chairs = 0;

        for ch in corridor.chars() {
            if ch == 'S' {
                chairs += 1;
            }
        }

        if chairs % 2 != 0 {
            return 0;
        }

        let target = chairs / 2;
        let mut ways = 1;
        let mut current = 0;

        for ch in corridor.chars() {
            if ch == 'S' {
                current += 1;
                if current == target {
                    break;
                }
            }
        }

        let mut last = 0;
        for ch in corridor.chars() {
            if ch == 'S' {
                last += 1;
                if last == target {
                    break;
                }
                if last > 0 && last < target {
                    ways = (ways * (current - last) as i64) % 1_000_000_007;
                }
            } else if last == target {
                current -= 1;
            }
        }

        ways as i32
    }
}