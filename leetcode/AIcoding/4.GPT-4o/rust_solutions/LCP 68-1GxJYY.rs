impl Solution {
    pub fn beautiful_bouquet(flowers: Vec<i32>, limit: i32) -> i32 {
        let mut count = std::collections::HashMap::new();
        let mut max_beauty = 0;

        for &flower in &flowers {
            *count.entry(flower).or_insert(0) += 1;
            if count.len() > limit as usize {
                let mut min_key = *count.keys().next().unwrap();
                for &key in count.keys() {
                    if count[&key] < count[&min_key] {
                        min_key = key;
                    }
                }
                count.remove(&min_key);
            }
            max_beauty = max_beauty.max(count.iter().map(|(_, &v)| v).sum());
        }

        max_beauty
    }
}