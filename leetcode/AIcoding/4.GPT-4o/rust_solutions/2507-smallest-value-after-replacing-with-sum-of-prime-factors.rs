pub fn smallest_value(n: i32) -> i32 {
    fn prime_factors_sum(mut n: i32) -> i32 {
        let mut sum = 0;
        let mut factor = 2;
        while factor * factor <= n {
            while n % factor == 0 {
                sum += factor;
                n /= factor;
            }
            factor += 1;
        }
        if n > 1 {
            sum += n;
        }
        sum
    }

    let mut current = n;
    loop {
        let next = prime_factors_sum(current);
        if next == current {
            break;
        }
        current = next;
    }
    current
}