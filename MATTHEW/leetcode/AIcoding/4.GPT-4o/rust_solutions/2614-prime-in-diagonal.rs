impl Solution {
    pub fn diagonal_prime(mat: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashSet;

        let mut max_prime = 0;
        let mut primes = HashSet::new();

        for i in 2..=100 {
            if (2..=i).all(|j| i % j != 0 || j == i) {
                primes.insert(i);
            }
        }

        let n = mat.len();
        for i in 0..n {
            if primes.contains(&(mat[i][i])) {
                max_prime = max_prime.max(mat[i][i]);
            }
            if primes.contains(&(mat[i][n - 1 - i])) {
                max_prime = max_prime.max(mat[i][n - 1 - i]);
            }
        }

        max_prime
    }
}