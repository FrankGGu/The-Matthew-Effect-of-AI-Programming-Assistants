struct Solution;

impl Solution {
    pub fn find_min_fibonacci_numbers(k: i32) -> i32 {
        let mut fib_numbers = vec![1, 1];
        while *fib_numbers.last().unwrap() < k {
            let next_fib = fib_numbers[fib_numbers.len() - 1] + fib_numbers[fib_numbers.len() - 2];
            if next_fib > k {
                break;
            }
            fib_numbers.push(next_fib);
        }

        let mut current_k = k;
        let mut count = 0;

        for i in (0..fib_numbers.len()).rev() {
            if current_k == 0 {
                break;
            }
            if fib_numbers[i] <= current_k {
                current_k -= fib_numbers[i];
                count += 1;
            }
        }
        count
    }
}