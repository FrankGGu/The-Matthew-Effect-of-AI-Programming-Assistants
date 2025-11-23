use std::collections::BTreeMap;

struct OrdinalRankTracker {
    ranks: BTreeMap<i32, i32>,
}

impl OrdinalRankTracker {
    fn new() -> Self {
        OrdinalRankTracker {
            ranks: BTreeMap::new(),
        }
    }

    fn track(&mut self, number: i32) {
        *self.ranks.entry(number).or_insert(0) += 1;
    }

    fn get_rank(&self, number: i32) -> i32 {
        self.ranks.range(..number).map(|(&k, &v)| v).sum::<i32>() + self.ranks.get(&number).unwrap_or(&0)
    }

    fn get_total(&self) -> i32 {
        self.ranks.values().sum()
    }
}