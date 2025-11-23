impl Solution {
    pub fn minimum_numbers(num: i32, k: i32) -> i32 {
        if num == 0 {
            return 0;
        }
        for i in 1..=10 {
            if (i * k) % 10 == num % 10 && i * k <= num {
                return i;
            }
        }
        -1
    }
}