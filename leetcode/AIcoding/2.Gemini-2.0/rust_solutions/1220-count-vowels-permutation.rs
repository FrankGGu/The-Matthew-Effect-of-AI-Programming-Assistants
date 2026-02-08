impl Solution {
    pub fn count_vowel_permutation(n: i32) -> i32 {
        let n = n as usize;
        let modulo = 1_000_000_007;

        let mut a = 1;
        let mut e = 1;
        let mut i = 1;
        let mut o = 1;
        let mut u = 1;

        for _ in 1..n {
            let new_a = (e + i + u) % modulo;
            let new_e = (a + i) % modulo;
            let new_i = (e + o) % modulo;
            let new_o = i;
            let new_u = (i + o) % modulo;

            a = new_a;
            e = new_e;
            i = new_i;
            o = new_o;
            u = new_u;
        }

        (((a + e) % modulo + (i + o) % modulo) % modulo + u) % modulo
    }
}