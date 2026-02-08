impl Solution {
    pub fn count_bad_pairs(nums: Vec<i32>) -> i64 {
        let n = nums.len() as i64;
        let mut count = 0;
        let mut map = std::collections::HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            let diff = (i as i64) - (num as i64);
            *map.entry(diff).or_insert(0) += 1;
        }

        for &v in map.values() {
            count += v * (v - 1) / 2;
        }

        count = n * (n - 1) / 2 - count;
        count
    }
}