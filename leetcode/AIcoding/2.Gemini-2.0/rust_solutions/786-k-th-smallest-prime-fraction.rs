impl Solution {
    pub fn kth_smallest_prime_fraction(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let n = arr.len();
        let mut fractions: Vec<(i32, i32)> = Vec::with_capacity(n * (n - 1) / 2);
        for i in 0..n {
            for j in i + 1..n {
                fractions.push((arr[i], arr[j]));
            }
        }

        fractions.sort_by(|&(a, b), &(c, d)| {
            (a as f64 / b as f64).partial_cmp(&(c as f64 / d as f64)).unwrap()
        });

        let (num, den) = fractions[(k - 1) as usize];
        vec![num, den]
    }
}