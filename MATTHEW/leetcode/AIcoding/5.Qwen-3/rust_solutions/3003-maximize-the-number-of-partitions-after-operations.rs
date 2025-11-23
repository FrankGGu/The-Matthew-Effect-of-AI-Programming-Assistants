struct Solution;

impl Solution {
    pub fn max_partitions(s: String) -> i32 {
        let mut result = 0;
        let mut last = -1;
        let mut map = std::collections::HashMap::new();

        for (i, c) in s.chars().enumerate() {
            map.insert(c, i as i32);
        }

        let mut i = 0;
        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            let j = map[&c];
            let mut max_pos = j;
            let mut k = i;
            while k <= j {
                let ch = s.chars().nth(k).unwrap();
                max_pos = std::cmp::max(max_pos, map[&ch]);
                k += 1;
            }
            result += 1;
            i = max_pos + 1;
        }

        result
    }
}