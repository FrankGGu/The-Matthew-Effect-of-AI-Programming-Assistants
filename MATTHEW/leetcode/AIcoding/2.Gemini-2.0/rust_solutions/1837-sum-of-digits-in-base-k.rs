impl Solution {
    pub fn sum_base(n: i32, k: i32) -> i32 {
        let mut num = n;
        let mut sum = 0;
        while num > 0 {
            sum += num % k;
            num /= k;
        }
        sum
    }
}