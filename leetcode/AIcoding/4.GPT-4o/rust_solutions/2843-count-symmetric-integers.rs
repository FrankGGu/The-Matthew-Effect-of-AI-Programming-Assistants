impl Solution {
    pub fn count_symmetric_integers(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for num in low..=high {
            let sum1 = num.to_string().chars().take((num.to_string().len() + 1) / 2).map(|c| c.to_digit(10).unwrap()).sum::<u32>();
            let sum2 = num.to_string().chars().skip((num.to_string().len() + 1) / 2).map(|c| c.to_digit(10).unwrap()).sum::<u32>();
            if sum1 == sum2 {
                count += 1;
            }
        }
        count
    }
}