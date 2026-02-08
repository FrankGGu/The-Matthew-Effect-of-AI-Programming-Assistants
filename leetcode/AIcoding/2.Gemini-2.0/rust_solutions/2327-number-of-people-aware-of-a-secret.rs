impl Solution {
    pub fn number_of_people_aware_of_a_secret(n: i32, delay: i32, forget: i32) -> i32 {
        let n = n as usize;
        let delay = delay as usize;
        let forget = forget as usize;

        let mut aware = vec![0; n];
        aware[0] = 1;

        let mut share = vec![0; n];
        share[0] = 1;

        for i in 1..n {
            for j in 0..i {
                if i >= j + delay && i < j + forget {
                    aware[i] = (aware[i] + share[j]) % 1000000007;
                }
            }
            share[i] = aware[i];
        }

        let mut ans = 0;
        for i in 0..n {
            if i + forget > n - 1 {
                ans = (ans + aware[i]) % 1000000007;
            }
        }

        ans
    }
}