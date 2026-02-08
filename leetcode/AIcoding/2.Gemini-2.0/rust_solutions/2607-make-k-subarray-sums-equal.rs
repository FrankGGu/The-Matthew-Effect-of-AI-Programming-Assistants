impl Solution {
    pub fn make_k_subarray_sums_equal(arr: Vec<i32>, k: i32) -> i64 {
        let n = arr.len();
        let k = k as usize % n;
        let mut ans = 0i64;
        for i in 0..gcd(n, k) {
            let mut cycle = Vec::new();
            let mut j = i;
            while !(cycle.contains(&j)) {
                cycle.push(arr[j]);
                j = (j + k) % n;
            }
            cycle.sort();
            let median = cycle[cycle.len() / 2];
            for &x in &cycle {
                ans += (x as i64 - median as i64).abs();
            }
        }
        ans
    }
}

fn gcd(a: usize, b: usize) -> usize {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

struct Solution;