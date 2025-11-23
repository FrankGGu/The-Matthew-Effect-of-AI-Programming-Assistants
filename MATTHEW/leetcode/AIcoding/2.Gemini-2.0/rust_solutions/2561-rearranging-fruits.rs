use std::collections::HashMap;

impl Solution {
    pub fn min_cost(fruits: Vec<i32>, baskets: Vec<Vec<i32>>) -> i64 {
        let n = baskets.len();
        let mut count: HashMap<i32, i32> = HashMap::new();
        for &fruit in &fruits {
            *count.entry(fruit).or_insert(0) += 1;
        }
        for basket in &baskets {
            for &fruit in basket {
                *count.entry(fruit).or_insert(0) += 1;
            }
        }

        let mut need_remove: HashMap<i32, i32> = HashMap::new();
        for (fruit, &cnt) in &count {
            if cnt % 2 != 0 {
                return -1;
            }
            let fruit_count = fruits.iter().filter(|&&x| x == *fruit).count() as i32;
            let basket_count = baskets.iter().map(|basket| basket.iter().filter(|&&x| x == *fruit).count() as i32).sum::<i32>();
            let diff = fruit_count - basket_count;
            if diff > 0 {
                *need_remove.entry(*fruit).or_insert(0) += diff / 2;
            }
        }

        let mut costs = Vec::new();
        for (&fruit, &cnt) in &need_remove {
            for _ in 0..cnt {
                costs.push(fruit);
            }
        }
        costs.sort();

        let min_val = *count.keys().min().unwrap();
        let mut total_cost: i64 = 0;
        for i in 0..costs.len() {
            total_cost += i64::min(2 * min_val as i64, costs[i] as i64);
        }

        total_cost
    }
}