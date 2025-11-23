impl Solution {
    pub fn get_kth(lo: i32, hi: i32, k: i32) -> i32 {
        let mut power_values: Vec<(i32, i32)> = (lo..=hi)
            .map(|x| (x, Self::power_value(x)))
            .collect();
        power_values.sort_by(|a, b| {
            if a.1 == b.1 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });
        power_values[(k as usize) - 1].0
    }

    fn power_value(mut x: i32) -> i32 {
        let mut steps = 0;
        while x != 1 {
            if x % 2 == 0 {
                x /= 2;
            } else {
                x = 3 * x + 1;
            }
            steps += 1;
        }
        steps
    }
}