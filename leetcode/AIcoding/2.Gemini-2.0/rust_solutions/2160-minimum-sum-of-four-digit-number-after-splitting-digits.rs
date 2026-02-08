impl Solution {
    pub fn minimum_sum(num: i32) -> i32 {
        let mut digits: Vec<i32> = Vec::new();
        let mut temp = num;
        while temp > 0 {
            digits.push(temp % 10);
            temp /= 10;
        }
        digits.sort();
        (digits[0] + digits[1]) * 10 + digits[2] + digits[3]
    }
}