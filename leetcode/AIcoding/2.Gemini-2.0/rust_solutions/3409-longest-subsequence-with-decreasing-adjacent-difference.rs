impl Solution {
    pub fn longest_subsequence(arr: Vec<i32>, difference: i32) -> i32 {
        use std::collections::HashMap;

        let mut dp: HashMap<i32, i32> = HashMap::new();
        let mut max_len = 0;

        for &num in &arr {
            let prev = num - difference;
            let len = dp.get(&prev).map(|&l| l + 1).unwrap_or(1);
            dp.insert(num, len);
            max_len = max_len.max(len);
        }

        max_len
    }
}