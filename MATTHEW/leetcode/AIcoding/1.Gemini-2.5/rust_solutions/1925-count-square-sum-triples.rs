impl Solution {
    pub fn count_triples(n: i32) -> i32 {
        let mut count = 0;
        for a in 1..=n {
            for b in 1..=n {
                let a_squared = a * a;
                let b_squared = b * b;
                let c_squared = a_squared + b_squared;

                // Optimization: if c_squared is already greater than n*n,
                // then c would be greater than n. Since 'b' is increasing,
                // all subsequent values of 'b' for the current 'a' will also
                // result in c > n. So we can break from the inner loop.
                if c_squared > n * n {
                    break;
                }

                let c_float = (c_squared as f64).sqrt();
                let c_int = c_float as i32;

                // Check if c is an integer and within the range [1, n]
                if c_int * c_int == c_squared && c_int <= n {
                    count += 1;
                }
            }
        }
        count
    }
}