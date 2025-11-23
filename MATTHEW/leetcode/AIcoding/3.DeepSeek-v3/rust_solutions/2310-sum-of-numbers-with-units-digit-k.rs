impl Solution {
    pub fn minimum_numbers(num: i32, k: i32) -> i32 {
        if num == 0 {
            return 0;
        }
        for n in 1..=10 {
            if n * k <= num && (num - n * k) % 10 == 0 {
                return n;
            }
        }
        -1
    }
}