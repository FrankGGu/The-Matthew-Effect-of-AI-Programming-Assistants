impl Solution {
    pub fn count_numbers_not_special(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            let mut num = i;
            let mut digits = vec![];
            while num > 0 {
                digits.push(num % 10);
                num /= 10;
            }
            digits.reverse();
            if digits.iter().any(|&d| d == 0 || digits.contains(&(d * 2))) {
                count += 1;
            }
        }
        n - count
    }
}