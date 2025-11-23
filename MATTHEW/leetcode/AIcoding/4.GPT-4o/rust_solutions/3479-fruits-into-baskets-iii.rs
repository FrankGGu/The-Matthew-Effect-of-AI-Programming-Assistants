impl Solution {
    pub fn total_fruit(tree: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut left = 0;
        let mut max_fruits = 0;
        let mut map = HashMap::new();

        for right in 0..tree.len() {
            *map.entry(tree[right]).or_insert(0) += 1;

            while map.len() > 2 {
                let count = map.get(&tree[left]).unwrap();
                if *count == 1 {
                    map.remove(&tree[left]);
                } else {
                    *map.get_mut(&tree[left]).unwrap() -= 1;
                }
                left += 1;
            }

            max_fruits = max_fruits.max(right - left + 1);
        }

        max_fruits
    }
}