pub fn max_fruit_count_from_tree(tree: Vec<i32>) -> i32 {
    use std::collections::HashMap;

    let mut left = 0;
    let mut max_count = 0;
    let mut fruit_count = HashMap::new();

    for right in 0..tree.len() {
        *fruit_count.entry(tree[right]).or_insert(0) += 1;

        while fruit_count.len() > 2 {
            let left_fruit = tree[left];
            if let Some(count) = fruit_count.get_mut(&left_fruit) {
                *count -= 1;
                if *count == 0 {
                    fruit_count.remove(&left_fruit);
                }
            }
            left += 1;
        }

        max_count = max_count.max(right - left + 1);
    }

    max_count
}