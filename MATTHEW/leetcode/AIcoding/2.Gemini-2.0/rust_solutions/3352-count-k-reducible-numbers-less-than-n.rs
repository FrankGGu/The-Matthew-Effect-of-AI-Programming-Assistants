impl Solution {
    pub fn count_k_reducible_numbers(n: i64, k: i32) -> i32 {
        let k_i64 = k as i64;
        let mut count = 0;

        for i in 1..=n {
            let mut num = i;
            while num % k_i64 == 0 {
                num /= k_i64;
            }
            if num % k_i64 != 0 {
                count += 1;
            }
        }

        count as i32
    }
}