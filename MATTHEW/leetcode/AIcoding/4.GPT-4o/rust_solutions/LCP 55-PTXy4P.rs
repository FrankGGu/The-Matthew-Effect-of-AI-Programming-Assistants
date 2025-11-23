impl Solution {
    pub fn max_fruit_count(tree: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = 0;
        let mut count = std::collections::HashMap::new();
        let mut max_fruits = 0;

        while right < tree.len() {
            *count.entry(tree[right]).or_insert(0) += 1;

            while count.len() > 2 {
                let fruit = tree[left];
                *count.get_mut(&fruit).unwrap() -= 1;
                if count[&fruit] == 0 {
                    count.remove(&fruit);
                }
                left += 1;
            }

            max_fruits = max_fruits.max(right - left + 1);
            right += 1;
        }

        max_fruits
    }
}