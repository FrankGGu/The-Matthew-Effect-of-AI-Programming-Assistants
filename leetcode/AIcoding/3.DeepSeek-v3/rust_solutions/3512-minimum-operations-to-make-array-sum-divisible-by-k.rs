impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();
        let remainder = (total_sum % k as i64).abs() as i32;
        if remainder == 0 {
            return 0;
        }
        let mut freq = std::collections::HashMap::new();
        let mut prefix_sum = 0;
        let mut min_len = nums.len() as i32 + 1;
        freq.insert(0, -1);

        for (i, &num) in nums.iter().enumerate() {
            prefix_sum = (prefix_sum + num) % k;
            let target = (prefix_sum - remainder + k) % k;
            if let Some(&pos) = freq.get(&target) {
                min_len = min_len.min(i as i32 - pos);
            }
            freq.entry(prefix_sum).or_insert(i as i32);
        }

        if min_len <= nums.len() as i32 {
            min_len
        } else {
            -1
        }
    }
}