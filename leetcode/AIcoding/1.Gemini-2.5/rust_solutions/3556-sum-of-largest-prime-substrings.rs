impl Solution {
    pub fn sum_of_largest_prime_substrings(s: String) -> i64 {
        let n = s.len();
        let mut total_sum: i64 = 0;

        for i in 0..n {
            let mut max_prime_for_current_start: u64 = 0;

            for j in i..n {
                let sub_str = &s[i..=j];

                if sub_str.len() > 1 && sub_str.starts_with('0') {
                    continue;
                }

                if let Ok(num) = sub_str.parse::<u64>() {
                    if is_prime(num) {
                        if num > max_prime_for_current_start {
                            max_prime_for_current_start = num;
                        }
                    }
                }
            }
            total_sum += max_prime_for_current_start as i64;
        }

        total_sum
    }
}

fn is_prime(n: u64) -> bool {
    if n <= 1 {
        return false;
    }
    if n <= 3 {
        return true;
    }
    if n % 2 == 0 || n % 3 == 0 {
        return false;
    }
    let mut i = 5;
    while i * i <= n {
        if n % i == 0 || n % (i + 2) == 0 {
            return false;
        }
        i += 6;
    }
    true
}