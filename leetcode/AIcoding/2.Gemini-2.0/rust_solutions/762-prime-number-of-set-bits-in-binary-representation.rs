impl Solution {
    pub fn count_prime_set_bits(left: i32, right: i32) -> i32 {
        let mut count = 0;
        for i in left..=right {
            let bits = i.count_ones();
            if Self::is_prime(bits as i32) {
                count += 1;
            }
        }
        count
    }

    fn is_prime(n: i32) -> bool {
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
}