pub fn max_fruits(fruits: Vec<i32>, limit: i32) -> i32 {
    let mut count = std::collections::HashMap::new();
    let (mut left, mut max_fruits) = (0, 0);

    for right in 0..fruits.len() {
        *count.entry(fruits[right]).or_insert(0) += 1;

        while count.len() > limit as usize {
            let fruit = fruits[left];
            *count.get_mut(&fruit).unwrap() -= 1;
            if count[&fruit] == 0 {
                count.remove(&fruit);
            }
            left += 1;
        }

        max_fruits = max_fruits.max(right - left + 1);
    }

    max_fruits
}