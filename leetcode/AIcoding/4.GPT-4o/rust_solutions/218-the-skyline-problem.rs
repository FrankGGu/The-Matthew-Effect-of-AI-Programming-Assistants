use std::collections::BTreeMap;

pub fn get_skyline(buildings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut events = Vec::new();
    for building in &buildings {
        events.push((building[0], -building[2]));
        events.push((building[1], building[2]));
    }
    events.sort();

    let mut heights = BTreeMap::new();
    let mut result = Vec::new();
    let mut prev_height = 0;

    for (x, h) in events {
        if h < 0 {
            *heights.entry(-h).or_insert(0) += 1;
        } else {
            if let Some(count) = heights.get_mut(&h) {
                *count -= 1;
                if *count == 0 {
                    heights.remove(&h);
                }
            }
        }

        let current_height = heights.iter().next_back().map_or(0, |(&h, _)| h);

        if current_height != prev_height {
            result.push(vec![x, current_height]);
            prev_height = current_height;
        }
    }

    result
}