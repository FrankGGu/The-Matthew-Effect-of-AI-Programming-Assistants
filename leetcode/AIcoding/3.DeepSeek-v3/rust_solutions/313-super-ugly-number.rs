impl Solution {
    pub fn nth_super_ugly_number(n: i32, primes: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut ugly = vec![1; n];
        let mut pointers = vec![0; primes.len()];

        for i in 1..n {
            let mut min_val = i32::MAX;
            for j in 0..primes.len() {
                let candidate = ugly[pointers[j]] * primes[j];
                if candidate < min_val {
                    min_val = candidate;
                }
            }
            ugly[i] = min_val;
            for j in 0..primes.len() {
                if ugly[pointers[j]] * primes[j] == min_val {
                    pointers[j] += 1;
                }
            }
        }

        ugly[n - 1]
    }
}