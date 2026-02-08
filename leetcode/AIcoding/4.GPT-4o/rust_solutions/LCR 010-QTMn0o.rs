use std::collections::HashMap;

pub fn subarray_sum(nums: Vec<i32>, k: i32) -> i32 {
    let mut count = 0;
    let mut sum = 0;
    let mut map = HashMap::new();
    map.insert(0, 1);

    for &num in &nums {
        sum += num;
        if let Some(&val) = map.get(&(sum - k)) {
            count += val;
        }
        *map.entry(sum).or_insert(0) += 1;
    }

    count
}