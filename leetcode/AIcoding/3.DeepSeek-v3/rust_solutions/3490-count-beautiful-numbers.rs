impl Solution {
    pub fn count_beautiful_numbers(n: i32) -> i32 {
        let n = n as usize;
        let mut count = 0;
        for num in 1..=n {
            let digits: Vec<_> = num.to_string().chars().map(|c| c.to_digit(10).unwrap()).collect();
            let mut product = 1;
            let mut sum = 0;
            for &d in &digits {
                product *= d;
                sum += d;
            }
            if product % sum == 0 {
                count += 1;
            }
        }
        count
    }
}