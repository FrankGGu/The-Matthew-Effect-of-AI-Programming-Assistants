use std::collections::HashMap;

impl Solution {
    pub fn get_kth(lo: i32, hi: i32, k: i32) -> i32 {
        let mut memo: HashMap<i32, i32> = HashMap::new();
        let mut power_values: Vec<(i32, i32)> = Vec::new();

        fn calculate_power(n: i32, memo: &mut HashMap<i32, i32>) -> i32 {
            if n == 1 {
                return 0;
            }
            if let Some(&val) = memo.get(&n) {
                return val;
            }

            let power = if n % 2 == 0 {
                1 + calculate_power(n / 2, memo)
            } else {
                1 + calculate_power(3 * n + 1, memo)
            };

            memo.insert(n, power);
            power
        }

        for i in lo..=hi {
            let power = calculate_power(i, &mut memo);
            power_values.push((i, power));
        }

        power_values.sort_by(|a, b| {
            if a.1 == b.1 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        power_values[(k - 1) as usize].0
    }
}