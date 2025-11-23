impl Solution {
    pub fn max_prime_in_diagonal(mat: Vec<Vec<i32>>) -> i32 {
        fn is_prime(n: i32) -> bool {
            if n <= 1 {
                return false;
            }
            if n == 2 {
                return true;
            }
            if n % 2 == 0 {
                return false;
            }
            let limit = (n as f64).sqrt() as i32;
            for i in (3..=limit).step_by(2) {
                if n % i == 0 {
                    return false;
                }
            }
            true
        }

        let n = mat.len();
        let mut max_prime = 0;

        for i in 0..n {
            // Main diagonal element
            let num1 = mat[i][i];
            if is_prime(num1) {
                max_prime = std::cmp::max(max_prime, num1);
            }

            // Anti-diagonal element
            let num2 = mat[i][n - 1 - i];
            if is_prime(num2) {
                max_prime = std::cmp::max(max_prime, num2);
            }
        }

        max_prime
    }
}