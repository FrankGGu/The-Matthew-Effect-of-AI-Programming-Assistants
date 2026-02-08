impl Solution {
    pub fn count_k_reducible_numbers(n: i32, k: i32) -> i32 {
        let mut count = 0;

        for i in 1..n {
            let mut num = i;
            let mut k_count = 0;

            while num > 0 {
                if num % 10 > k {
                    k_count += 1;
                }
                num /= 10;
            }

            if k_count <= k {
                count += 1;
            }
        }

        count
    }
}