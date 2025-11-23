use std::collections::HashMap;

pub fn count_excellent_pairs(nums: Vec<i32>, k: i32) -> i64 {
    let mut count_map = HashMap::new();
    let mut unique_nums = nums.into_iter().collect::<std::collections::HashSet<_>>().into_iter().collect::<Vec<_>>();

    for &num in &unique_nums {
        let bit_count = num.count_ones();
        *count_map.entry(bit_count).or_insert(0) += 1;
    }

    let mut result = 0;
    let bit_counts: Vec<_> = count_map.keys().cloned().collect();

    for &x in &bit_counts {
        for &y in &bit_counts {
            if x + y >= k {
                result += (count_map[&x] as i64) * (count_map[&y] as i64);
            }
        }
    }

    result
}