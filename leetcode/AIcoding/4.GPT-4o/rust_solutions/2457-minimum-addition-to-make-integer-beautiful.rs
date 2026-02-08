impl Solution {
    pub fn minimum_beautiful(*n: i64) -> i64 {
        let mut count = 0;
        let mut number = *n;
        while number > 0 {
            if number % 10 != 0 {
                count += 10 - number % 10;
                number += 10 - number % 10;
            }
            number /= 10;
        }
        count
    }
}