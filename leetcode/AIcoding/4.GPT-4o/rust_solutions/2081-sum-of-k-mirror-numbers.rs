impl Solution {
    pub fn k_mirror(k: i32, n: i32) -> i64 {
        fn is_palindrome(num: &str) -> bool {
            num == num.chars().rev().collect::<String>()
        }

        fn to_base_k(num: u64, k: u32) -> String {
            let mut n = num;
            let mut result = String::new();
            while n > 0 {
                result.push_str(&(n % k as u64).to_string());
                n /= k as u64;
            }
            result.chars().rev().collect()
        }

        let mut count = 0;
        let mut sum = 0;
        let mut num = 1;

        while count < n {
            let str_num = num.to_string();
            if is_palindrome(&str_num) {
                let base_k = to_base_k(num, k as u32);
                if is_palindrome(&base_k) {
                    sum += num;
                    count += 1;
                }
            }
            num += 1;
        }

        sum
    }
}