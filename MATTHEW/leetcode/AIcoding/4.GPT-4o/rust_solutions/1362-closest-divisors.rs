impl Solution {
    pub fn closest_divisors(num: i32) -> Vec<i32> {
        let num1 = num + 1;
        let num2 = num + 2;
        let mut result = vec![0, 0];
        let mut min_diff = i32::MAX;

        for &n in &[num1, num2] {
            for i in (1..=n as f64).sqrt() as i32..=n {
                if n % i == 0 {
                    let j = n / i;
                    let diff = (i - j).abs();
                    if diff < min_diff {
                        min_diff = diff;
                        result = vec![i, j];
                    }
                }
            }
        }

        result
    }
}