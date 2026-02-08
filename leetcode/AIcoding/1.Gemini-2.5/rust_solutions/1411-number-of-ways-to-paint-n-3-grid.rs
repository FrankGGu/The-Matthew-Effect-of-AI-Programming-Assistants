impl Solution {
    pub fn num_ways(n: i32) -> i32 {
        let n = n as usize;
        let modulo = 1_000_000_007;

        let mut dp_aba: i64 = 6;
        let mut dp_abc: i64 = 6;

        for _i in 2..=n {
            let next_dp_aba = (3 * dp_aba + 2 * dp_abc) % modulo;
            let next_dp_abc = (2 * dp_aba + 2 * dp_abc) % modulo;

            dp_aba = next_dp_aba;
            dp_abc = next_dp_abc;
        }

        ((dp_aba + dp_abc) % modulo) as i32
    }
}