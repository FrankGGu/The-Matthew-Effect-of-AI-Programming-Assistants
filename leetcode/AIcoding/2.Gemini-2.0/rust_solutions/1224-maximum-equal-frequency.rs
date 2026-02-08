use std::collections::HashMap;

impl Solution {
    pub fn max_equal_freq(nums: Vec<i32>) -> i32 {
        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        let mut count_map: HashMap<i32, i32> = HashMap::new();
        let mut max_freq = 0;
        let mut ans = 0;

        for (i, &num) in nums.iter().enumerate() {
            let freq = freq_map.entry(num).or_insert(0);
            let old_freq = *freq;
            *freq += 1;
            let new_freq = *freq;

            if old_freq > 0 {
                let old_count = count_map.entry(old_freq).or_insert(0);
                *old_count -= 1;
                if *old_count == 0 {
                    count_map.remove(&old_freq);
                }
            }

            let new_count = count_map.entry(new_freq).or_insert(0);
            *new_count += 1;

            max_freq = max_freq.max(new_freq);

            if count_map.len() == 1 {
                if count_map.contains_key(&1) || count_map.contains_key(&max_freq) && *count_map.get(&max_freq).unwrap() == 1 {
                    ans = (i + 1) as i32;
                }
            } else if count_map.len() == 2 {
                let mut freqs: Vec<i32> = count_map.keys().cloned().collect();
                freqs.sort();

                if freqs[0] == 1 && *count_map.get(&1).unwrap() == 1 {
                    ans = (i + 1) as i32;
                } else if freqs[1] == max_freq && freqs[0] == max_freq - 1 && *count_map.get(&max_freq).unwrap() == 1 {
                    ans = (i + 1) as i32;
                }
            }
        }

        ans
    }
}