impl Solution {
    pub fn final_array_state_after_k_multiplication_operations_i(n: i32, k: i64) -> Vec<i32> {
        let n_long = n as i64;

        let q = k / n_long;
        let r = k % n_long;

        let mut result: Vec<i32> = Vec::with_capacity(n as usize);

        let val_q = 1i32 << q;
        let val_q_plus_1 = 1i32 << (q + 1);

        for _ in 0..r {
            result.push(val_q_plus_1);
        }

        for _ in 0..(n_long - r) {
            result.push(val_q);
        }

        result
    }
}