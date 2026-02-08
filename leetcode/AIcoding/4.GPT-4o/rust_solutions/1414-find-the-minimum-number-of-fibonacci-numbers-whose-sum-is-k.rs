impl Solution {
    pub fn find_fibonacci_numbers(k: i32) -> i32 {
        let mut fib = vec![1, 2];
        while let Some(&last) = fib.last() {
            let next = last + fib[fib.len() - 2];
            if next > k {
                break;
            }
            fib.push(next);
        }

        let mut count = 0;
        let mut remaining = k;

        for &num in fib.iter().rev() {
            while remaining >= num {
                remaining -= num;
                count += 1;
            }
            if remaining == 0 {
                break;
            }
        }

        count
    }
}