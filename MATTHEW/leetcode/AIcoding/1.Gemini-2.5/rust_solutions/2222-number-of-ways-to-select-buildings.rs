impl Solution {
    pub fn number_of_ways(s: String) -> i64 {
        let mut zero_count: i64 = 0;
        let mut one_count: i64 = 0;
        let mut zero_one_count: i64 = 0;
        let mut one_zero_count: i64 = 0;
        let mut total_ways: i64 = 0;

        for c in s.chars() {
            if c == '0' {
                total_ways += zero_one_count;
                one_zero_count += one_count;
                zero_count += 1;
            } else { // c == '1'
                total_ways += one_zero_count;
                zero_one_count += zero_count;
                one_count += 1;
            }
        }

        total_ways
    }
}