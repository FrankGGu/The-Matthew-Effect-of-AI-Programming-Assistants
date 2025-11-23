impl Solution {
    pub fn largest_sum_after_k_negations(A: Vec<i32>, K: i32) -> i32 {
        let mut A = A;
        A.sort();
        let mut k = K;

        for i in 0..A.len() {
            if k > 0 && A[i] < 0 {
                A[i] = -A[i];
                k -= 1;
            }
        }

        if k % 2 == 1 {
            A.sort();
            A[0] = -A[0];
        }

        A.iter().sum()
    }
}