impl Solution {
    pub fn count_symmetric_integers(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for i in low..=high {
            let s = i.to_string();
            let n = s.len();
            if n % 2 == 0 {
                let mut sum1 = 0;
                let mut sum2 = 0;
                for j in 0..n / 2 {
                    sum1 += s.chars().nth(j).unwrap().to_digit(10).unwrap();
                }
                for j in n / 2..n {
                    sum2 += s.chars().nth(j).unwrap().to_digit(10).unwrap();
                }
                if sum1 == sum2 {
                    count += 1;
                }
            }
        }
        count
    }
}