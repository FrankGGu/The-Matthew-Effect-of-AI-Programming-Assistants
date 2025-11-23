impl Solution {
    pub fn pivot_integer(n: i32) -> i32 {
        let total_sum_up_to_n = n * (n + 1) / 2;

        for x in 1..=n {
            let x_squared = x * x;
            if x_squared == total_sum_up_to_n {
                return x;
            }
            if x_squared > total_sum_up_to_n {
                return -1;
            }
        }

        -1
    }
}