impl Solution {
    pub fn count_good_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut count = 0;
        for i in 0..n - 2 {
            let mut map = std::collections::HashMap::new();
            for j in i..i + 3 {
                *map.entry(nums[j]).or_insert(0) += 1;
            }
            let mut pairs = 0;
            for &val in map.values() {
                pairs += val * (val - 1) / 2;
            }
            if pairs >= k {
                count += 1;
            }
        }
        count
    }
}