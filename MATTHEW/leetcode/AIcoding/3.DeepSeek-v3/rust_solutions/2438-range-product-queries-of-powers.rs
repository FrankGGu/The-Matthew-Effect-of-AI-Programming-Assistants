impl Solution {
    pub fn product_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut powers = Vec::new();
        let mut num = n;
        let mut bit = 0;
        while num > 0 {
            if num & 1 == 1 {
                powers.push(1 << bit);
            }
            num >>= 1;
            bit += 1;
        }

        let mut prefix = vec![1; powers.len() + 1];
        for i in 0..powers.len() {
            prefix[i + 1] = (prefix[i] as i64 * powers[i] as i64 % 1_000_000_007) as i32;
        }

        queries.into_iter().map(|q| {
            let (l, r) = (q[0] as usize, q[1] as usize);
            ((prefix[r + 1] as i64 * mod_inverse(prefix[l] as i64, 1_000_000_007) % 1_000_000_007) as i32)
        }).collect()
    }
}

fn mod_inverse(a: i64, m: i64) -> i64 {
    let mut a = a;
    let mut m = m;
    let mut x0 = 0;
    let mut x1 = 1;
    let mut b = m;

    while a > 1 {
        let q = a / b;
        let temp = b;
        b = a % b;
        a = temp;
        let temp = x0;
        x0 = x1 - q * x0;
        x1 = temp;
    }

    if x1 < 0 {
        x1 += m;
    }
    x1
}