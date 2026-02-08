impl Solution {
    pub fn num_ways(s: String) -> i32 {
        let n = s.len();
        let ones = s.chars().filter(|&c| c == '1').count();

        if ones % 3 != 0 {
            return 0;
        }

        if ones == 0 {
            let m = n - 2;
            return ((m as i64) * ((m as i64) + 1) / 2 % 1000000007) as i32;
        }

        let target = ones / 3;
        let mut count = 0;
        let mut first = 0;
        let mut second = 0;

        let mut ones_count = 0;
        for i in 0..n {
            if s.chars().nth(i).unwrap() == '1' {
                ones_count += 1;
            }
            if ones_count == target {
                first += 1;
            }
            if ones_count == 2 * target {
                second += 1;
            }
        }

        ((first as i64) * (second as i64) % 1000000007) as i32
    }
}