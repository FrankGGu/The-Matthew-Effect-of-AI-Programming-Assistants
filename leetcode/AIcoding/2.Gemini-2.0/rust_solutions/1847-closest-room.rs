impl Solution {
    pub fn closest_room(rooms: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut sorted_rooms = rooms.clone();
        sorted_rooms.sort_by(|a, b| b[1].cmp(&b[1]));

        let mut indexed_queries: Vec<(usize, i32, i32)> = queries
            .iter()
            .enumerate()
            .map(|(i, q)| (i, q[0], q[1]))
            .collect();
        indexed_queries.sort_by(|a, b| b.2.cmp(&b.2));

        let mut result = vec![0; queries.len()];
        let mut room_set = std::collections::BTreeSet::new();
        let mut room_idx = 0;

        for (i, preferred, min_size) in indexed_queries {
            while room_idx < sorted_rooms.len() && sorted_rooms[room_idx][1] >= min_size {
                room_set.insert(sorted_rooms[room_idx][0]);
                room_idx += 1;
            }

            if room_set.is_empty() {
                result[i] = -1;
            } else {
                let mut best = -1;
                let mut min_diff = i32::MAX;

                if let Some(&floor) = room_set.range(..=preferred).next_back() {
                    if (preferred - floor).abs() < min_diff {
                        min_diff = (preferred - floor).abs();
                        best = floor;
                    }
                }

                if let Some(&ceil) = room_set.range(preferred..).next() {
                    if (preferred - ceil).abs() < min_diff {
                        min_diff = (preferred - ceil).abs();
                        best = ceil;
                    }
                }
                result[i] = best;
            }
        }

        result
    }
}