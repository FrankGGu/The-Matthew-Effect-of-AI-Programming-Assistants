impl Solution {
    pub fn count_k_reducible_numbers(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut sieve = vec![0; n];
        for i in 2..n {
            if sieve[i] == 0 {
                for j in (i..n).step_by(i) {
                    sieve[j] += 1;
                }
            }
        }
        (2..n).filter(|&x| sieve[x] == k).count() as i32
    }
}