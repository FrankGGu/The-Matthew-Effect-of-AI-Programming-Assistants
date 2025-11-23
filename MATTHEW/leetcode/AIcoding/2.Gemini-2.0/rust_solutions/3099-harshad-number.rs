impl Solution {
    pub fn is_harshad(n: i32) -> bool {
        let mut num = n;
        let mut sum = 0;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        n % sum == 0
    }
}