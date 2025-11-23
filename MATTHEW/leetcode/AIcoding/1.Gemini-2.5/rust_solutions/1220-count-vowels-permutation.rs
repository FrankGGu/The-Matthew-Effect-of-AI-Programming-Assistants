impl Solution {
    pub fn count_vowel_permutations(n: i32) -> i32 {
        let n_usize = n as usize;
        let modulo: i64 = 1_000_000_007;

        let mut a_count: i64 = 1;
        let mut e_count: i64 = 1;
        let mut i_count: i64 = 1;
        let mut o_count: i64 = 1;
        let mut u_count: i64 = 1;

        for _k in 2..=n_usize {
            let prev_a = a_count;
            let prev_e = e_count;
            let prev_i = i_count;
            let prev_o = o_count;
            let prev_u = u_count;

            // 'a' can be preceded by 'e', 'i', 'u'
            a_count = (prev_e + prev_i + prev_u) % modulo;
            // 'e' can be preceded by 'a', 'i'
            e_count = (prev_a + prev_i) % modulo;
            // 'i' can be preceded by 'e', 'o'
            i_count = (prev_e + prev_o) % modulo;
            // 'o' can be preceded by 'i'
            o_count = prev_i % modulo;
            // 'u' can be preceded by 'i', 'o'
            u_count = (prev_i + prev_o) % modulo;
        }

        let total_count = (a_count + e_count + i_count + o_count + u_count) % modulo;
        total_count as i32
    }
}