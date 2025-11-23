impl Solution {
    pub fn nth_super_ugly_number(n: i32, primes: Vec<i32>) -> i32 {
        let mut ugly_numbers = vec![1];
        let mut indices = vec![0; primes.len()];
        let mut next_values = primes.clone();

        for _ in 1..n {
            let next_ugly = *next_values.iter().min().unwrap();
            ugly_numbers.push(next_ugly);

            for i in 0..primes.len() {
                if next_values[i] == next_ugly {
                    indices[i] += 1;
                    next_values[i] = ugly_numbers[indices[i] as usize] * primes[i];
                }
            }
        }

        ugly_numbers[n as usize - 1]
    }
}