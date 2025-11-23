use std::collections::HashMap;

impl Solution {
    pub fn concatenated_divisibility(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as i64;
        let mut count = 0;
        let mut freq = HashMap::new();

        for &num in nums.iter() {
            let num = num as i64;
            let len = if num == 0 { 1 } else { ((num as f64).log10().floor() as i32 + 1) as i64 };
            let pow = 10i64.pow(len as u32) % k;

            for (prev_num, (prev_pow, prev_count)) in freq.iter() {
                if (num * prev_pow + prev_num) % k == 0 {
                    count += prev_count;
                }
                if (prev_num * pow + num) % k == 0 {
                    count += prev_count;
                }
            }

            let entry = freq.entry(num).or_insert((pow, 0));
            *entry = (entry.0, entry.1 + 1);
        }

        count
    }
}