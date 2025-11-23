struct Solution;

impl Solution {
    pub fn kth_smallest_instructions(instructions: String, k: i32) -> String {
        let mut k = k;
        let (mut n, mut m) = (0, 0);
        for c in instructions.chars() {
            if c == 'S' {
                n += 1;
            } else {
                m += 1;
            }
        }

        let mut res = Vec::new();
        let mut fact = vec![1; n + m + 1];
        for i in 1..=n + m {
            fact[i] = fact[i - 1] * i;
        }

        while n > 0 || m > 0 {
            if n == 0 {
                res.push('E');
                m -= 1;
                continue;
            }
            if m == 0 {
                res.push('S');
                n -= 1;
                continue;
            }

            let c = fact[n + m - 1] / (fact[n - 1] * fact[m]);
            if k <= c as i32 {
                res.push('S');
                n -= 1;
            } else {
                res.push('E');
                m -= 1;
                k -= c as i32;
            }
        }

        res.into_iter().collect()
    }
}