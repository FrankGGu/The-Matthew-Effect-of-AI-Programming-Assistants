use std::collections::BTreeMap;

impl Solution {
    pub fn maximum_product(nums: Vec<i32>, mut k: i32) -> i32 {
        let mut map: BTreeMap<i32, i32> = BTreeMap::new();
        for num in nums {
            *map.entry(num).or_insert(0) += 1;
        }

        let modulo: i64 = 1_000_000_007;

        while k > 0 && map.len() > 1 {
            // Get the smallest value and its count
            let (min_val, min_count) = map.pop_first().unwrap();

            // Get the next smallest distinct value
            let (&next_min_val, _) = map.first_key_value().unwrap();

            let diff = (next_min_val - min_val) as i64;

            // Cost to increment all `min_count` elements from `min_val` to `next_min_val`
            let cost = diff * min_count as i64;

            if k as i64 >= cost {
                k -= cost as i32;
                // All `min_count` elements are now `next_min_val`.
                // Add their count to `next_min_val`'s count in the map.
                *map.get_mut(&next_min_val).unwrap() += min_count;
            } else {
                // Not enough `k` to bring all `min_count` elements to `next_min_val`.
                // Distribute the remaining `k` among these `min_count` elements.
                let increment_per_element = k as i64 / min_count as i64;
                let remaining_k_distribute = k as i64 % min_count as i64;

                let final_min_val = min_val + increment_per_element as i32;

                // `min_count - remaining_k_distribute` elements get `final_min_val`.
                if (min_count - remaining_k_distribute as i32) > 0 {
                    *map.entry(final_min_val).or_insert(0) += (min_count - remaining_k_distribute as i32);
                }
                // `remaining_k_distribute` elements get `final_min_val + 1`.
                if remaining_k_distribute > 0 {
                    *map.entry(final_min_val + 1).or_insert(0) += remaining_k_distribute as i32;
                }
                k = 0; // All k increments used up
                break;
            }
        }

        // After the loop, if k > 0, it means all elements in the map are now equal (or there was only one distinct element initially).
        // Distribute the remaining k among all elements.
        if k > 0 && !map.is_empty() {
            let (min_val, min_count) = map.pop_first().unwrap(); // Should be the only entry

            let increment_per_element = k as i64 / min_count as i64;
            let remaining_k_distribute = k as i64 % min_count as i64;

            let final_min_val = min_val + increment_per_element as i32;

            if (min_count - remaining_k_distribute as i32) > 0 {
                *map.entry(final_min_val).or_insert(0) += (min_count - remaining_k_distribute as i32);
            }
            if remaining_k_distribute > 0 {
                *map.entry(final_min_val + 1).or_insert(0) += remaining_k_distribute as i32;
            }
        }

        // Calculate the final product
        let mut product: i64 = 1;
        for (val, count) in map {
            for _ in 0..count {
                product = (product * val as i64) % modulo;
            }
        }

        product as i32
    }
}