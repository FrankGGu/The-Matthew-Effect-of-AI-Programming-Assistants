impl Solution {
    pub fn smallest_good_base(n: String) -> String {
        let num = n.parse::<u64>().unwrap();
        let max_m = (64.0f64.ln() / 2.0f64.ln()) as u32;

        for m in (2..=max_m).rev() {
            let k = (num as f64).powf(1.0 / m as f64).round() as u64;
            if k >= 2 {
                let mut sum = 1;
                let mut curr = 1;
                for _ in 1..=m {
                    curr *= k;
                    sum += curr;
                }
                if sum == num {
                    return k.to_string();
                }
            }
        }

        (num - 1).to_string()
    }
}