impl Solution {
    pub fn nearest_palindromic(n: String) -> String {
        let len = n.len();
        let candidates = [
            (10u64.pow(len as u32) + 1).to_string(),
            (10u64.pow(len as u32 - 1) - 1).to_string(),
        ];

        let prefix = &n[..(len + 1) / 2];
        let prefix_num = prefix.parse::<u64>().unwrap();

        for i in -1..=1 {
            let new_prefix = (prefix_num as i64 + i).to_string();
            let new_len = new_prefix.len();
            let pal = if len % 2 == 0 {
                format!("{}{}", new_prefix, new_prefix.chars().rev().collect::<String>())
            } else {
                format!("{}{}", new_prefix, new_prefix.chars().rev().skip(1).collect::<String>())
            };
            candidates.push(pal);
        }

        let mut closest = String::new();
        let mut min_diff = u64::MAX;
        let original_num = n.parse::<u64>().unwrap();

        for candidate in candidates.iter() {
            let candidate_num = candidate.parse::<u64>().unwrap();
            if candidate_num != original_num {
                let diff = (candidate_num as i64 - original_num as i64).abs() as u64;
                if diff < min_diff || (diff == min_diff && candidate < &closest) {
                    min_diff = diff;
                    closest = candidate.clone();
                }
            }
        }

        closest
    }
}