use std::collections::BTreeMap;

impl Solution {
    pub fn min_operations_to_make_all_dishes_palatable(dishes: Vec<i32>, k: i32) -> i32 {
        let mut counts: BTreeMap<i32, i32> = BTreeMap::new();
        for &dish in &dishes {
            *counts.entry(dish).or_insert(0) += 1;
        }

        let mut operations = 0;

        loop {
            // Get the smallest dish value. BTreeMap's iter() gives sorted keys.
            let (&s, _) = counts.iter().next().unwrap();

            // If the smallest dish is already palatable, all dishes must be palatable.
            if s >= k {
                break;
            }

            // Get the largest dish value.
            let (&l, _) = counts.iter().next_back().unwrap();

            // Decrease the count of the smallest dish 's'.
            // This represents choosing one dish with value 's' to be modified.
            let s_count = counts.get_mut(&s).unwrap();
            *s_count -= 1;
            if *s_count == 0 {
                counts.remove(&s);
            }

            // Increase the count of the new dish value 's + l'.
            // This represents 'dishes[i] = dishes[i] + dishes[j]' where dishes[i] was 's' and dishes[j] was 'l'.
            *counts.entry(s + l).or_insert(0) += 1;

            operations += 1;
        }

        operations
    }
}