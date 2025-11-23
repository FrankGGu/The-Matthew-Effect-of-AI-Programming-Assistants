impl Solution {

use std::collections::{BTreeSet, HashMap};

struct SORTracker {
    locations: BTreeSet<(String, i32)>,
    id_map: HashMap<String, i32>,
    current_rank: i32,
}

impl SORTracker {
    fn new() -> Self {
        SORTracker {
            locations: BTreeSet::new(),
            id_map: HashMap::new(),
            current_rank: 0,
        }
    }

    fn add(&mut self, name: String, score: i32) {
        let id = *self.id_map.entry(name.clone()).or_insert_with(|| {
            let id = self.locations.len() as i32;
            self.id_map.insert(name.clone(), id);
            id
        });
        self.locations.insert((name, id));
    }

    fn query(&mut self) -> String {
        let mut result = String::new();
        let mut count = 0;
        for (name, id) in &self.locations {
            if count == self.current_rank {
                result = name.clone();
                break;
            }
            count += 1;
        }
        self.current_rank += 1;
        result
    }
}
}