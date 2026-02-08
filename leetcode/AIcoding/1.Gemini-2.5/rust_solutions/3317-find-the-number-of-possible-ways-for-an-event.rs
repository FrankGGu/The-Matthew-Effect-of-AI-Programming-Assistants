use std::collections::BTreeMap;

impl Solution {
    pub fn max_two_events(mut events: Vec<Vec<i32>>) -> i32 {
        events.sort_unstable_by_key(|e| e[0]);

        let mut max_total_value = 0;
        let mut map: BTreeMap<i32, i32> = BTreeMap::new();
        map.insert(0, 0);

        for event in events {
            let s = event[0];
            let e = event[1];
            let v = event[2];

            let best_prev_event_val = map.range(..s)
                                         .last()
                                         .map_or(0, |(_, &val)| val);

            max_total_value = max_total_value.max(v + best_prev_event_val);

            let current_max_at_e = map.range(..=e)
                                      .last()
                                      .map_or(0, |(_, &val)| val);

            let new_val_for_e = current_max_at_e.max(v);

            if map.get(&e).map_or(true, |&existing_val| new_val_for_e > existing_val) {
                map.insert(e, new_val_for_e);

                let mut keys_to_remove = Vec::new();
                for (&k_next, &val_next) in map.range((e + 1)..) {
                    if val_next <= new_val_for_e {
                        keys_to_remove.push(k_next);
                    } else {
                        break; 
                    }
                }
                for k in keys_to_remove {
                    map.remove(&k);
                }
            }
        }

        max_total_value
    }
}