impl Solution {
    pub fn find_min_fibonacci_numbers(k: i32) -> i32 {
        let mut fib: Vec<i32> = vec![1, 1];
        while fib.last().unwrap() <= &k {
            let next_fib = fib[fib.len() - 1] + fib[fib.len() - 2];
            fib.push(next_fib);
        }
        fib.pop();

        let mut remaining = k;
        let mut count = 0;
        for &f in fib.iter().rev() {
            if f <= remaining {
                remaining -= f;
                count += 1;
            }
        }
        count
    }
}