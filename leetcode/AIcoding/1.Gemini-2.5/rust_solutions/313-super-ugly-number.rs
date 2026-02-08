struct Solution;

impl Solution {
    pub fn nth_super_ugly_number(n: i32, primes: Vec<i32>) -> i32 {
        let n_usize = n as usize;
        let m = primes.len();

        let mut ugly = vec![0; n_usize];
        ugly[0] = 1;

        let mut pointers = vec![0; m];
        let mut next_multiples: Vec<i64> = vec![0; m];

        for i in 0..m {
            next_multiples[i] = primes[i] as i64;
        }

        for k in 1..n_usize {
            let mut min_val: i64 = i64::MAX;

            for i in 0..m {
                if next_multiples[i] < min_val {
                    min_val = next_multiples[i];
                }
            }

            ugly[k] = min_val as i32;

            for i in 0..m {
                if next_multiples[i] == min_val {
                    pointers[i] += 1;
                    next_multiples[i] = primes[i] as i64 * ugly[pointers[i]] as i64;
                }
            }
        }

        ugly[n_usize - 1]
    }
}