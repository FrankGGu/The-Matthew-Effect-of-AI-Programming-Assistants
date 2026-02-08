use std::collections::BTreeMap;

impl Solution {
    pub fn get_skyline(buildings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut events: Vec<(i32, i32, i32)> = Vec::new(); // (x, height, type)
        // type: -1 for start of building, 1 for end of building
        for building in buildings {
            let left = building[0];
            let right = building[1];
            let height = building[2];
            events.push((left, height, -1));
            events.push((right, height, 1));
        }

        // Sort events
        // 1. By x-coordinate
        // 2. If x-coordinates are equal:
        //    a. Start events (-1) before end events (1)
        //    b. If both are start events, taller building first (descending height)
        //    c. If both are end events, shorter building first (ascending height)
        events.sort_unstable_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0) // Sort by x-coordinate
            } else {
                // x-coordinates are equal
                if a.2 == -1 && b.2 == -1 { // Both are start events
                    b.1.cmp(&a.1) // Taller building first
                } else if a.2 == 1 && b.2 == 1 { // Both are end events
                    a.1.cmp(&b.1) // Shorter building first
                } else { // One start, one end
                    a.2.cmp(&b.2) // Start event (-1) before end event (1)
                }
            }
        });

        let mut output: Vec<Vec<i32>> = Vec::new();
        let mut active_heights: BTreeMap<i32, i32> = BTreeMap::new(); // height -> count
        active_heights.insert(0, 1); // Sentinel: ensures current_max_height is always at least 0

        let mut prev_max_height = 0; // The height of the skyline just before the current event's x-coordinate

        for event in events {
            let x = event.0;
            let height = event.1;
            let event_type = event.2;

            if event_type == -1 { // Start of a building
                *active_heights.entry(height).or_insert(0) += 1;
            } else { // End of a building
                *active_heights.get_mut(&height).unwrap() -= 1;
                if *active_heights.get(&height).unwrap() == 0 {
                    active_heights.remove(&height);
                }
            }

            // The current maximum height is the largest key in the BTreeMap
            let current_max_height = *active_heights.keys().rev().next().unwrap();

            // If the max height changes, add a new point to the skyline
            if current_max_height != prev_max_height {
                output.push(vec![x, current_max_height]);
                prev_max_height = current_max_height;
            }
        }

        output
    }
}