pub fn find_max_length(nums: Vec<i32>) -> i32 {
    let mut map = std::collections::HashMap::new();
    map.insert(0, -1);
    let mut max_length = 0;
    let mut count = 0;

    for (i, &num) in nums.iter().enumerate() {
        count += if num == 1 { 1 } else { -1 };
        if let Some(&j) = map.get(&count) {
            max_length = max_length.max(i as i32 - j);
        } else {
            map.insert(count, i as i32);
        }
    }

    max_length
}