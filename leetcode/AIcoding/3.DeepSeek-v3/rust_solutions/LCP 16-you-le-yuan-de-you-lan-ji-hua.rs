use std::collections::HashMap;

impl Solution {
    pub fn max_happy_groups(batch_size: i32, groups: Vec<i32>) -> i32 {
        let mut freq = vec![0; batch_size as usize];
        let mut res = 0;
        for &g in &groups {
            let rem = g % batch_size;
            if rem == 0 {
                res += 1;
            } else {
                freq[rem as usize] += 1;
            }
        }

        let mut memo = HashMap::new();

        res + Self::dfs(0, &freq, batch_size, &mut memo)
    }

    fn dfs(remain: i32, freq: &Vec<i32>, batch_size: i32, memo: &mut HashMap<String, i32>) -> i32 {
        let key = Self::get_key(remain, freq);
        if let Some(&val) = memo.get(&key) {
            return val;
        }

        let mut max = 0;
        for i in 1..batch_size {
            if freq[i as usize] == 0 {
                continue;
            }
            let mut new_freq = freq.clone();
            new_freq[i as usize] -= 1;
            let new_remain = (remain - i + batch_size) % batch_size;
            let happy = if remain == 0 { 1 } else { 0 };
            let cur = happy + Self::dfs(new_remain, &new_freq, batch_size, memo);
            if cur > max {
                max = cur;
            }
        }

        memo.insert(key, max);
        max
    }

    fn get_key(remain: i32, freq: &Vec<i32>) -> String {
        let mut key = remain.to_string();
        for &f in freq {
            key.push_str(&f.to_string());
        }
        key
    }
}