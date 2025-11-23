impl Solution {
    pub fn max_rotate_function(a: Vec<i32>) -> i32 {
        let n = a.len();
        let sum: i32 = a.iter().sum();
        let mut f = (0..n).map(|i| i as i32 * a[i]).sum::<i32>();
        let mut max_f = f;

        for i in 1..n {
            f = f + sum - n as i32 * a[n - i];
            max_f = max_f.max(f);
        }

        max_f
    }
}