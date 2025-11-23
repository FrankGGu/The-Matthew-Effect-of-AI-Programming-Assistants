use std::collections::BTreeSet;

impl Solution {
    pub fn closest_room(rooms: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut rooms = rooms;
        rooms.sort_unstable_by(|a, b| b[1].cmp(&a[1]));

        let mut queries_with_index: Vec<(i32, i32, usize)> = queries
            .iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], i))
            .collect();
        queries_with_index.sort_unstable_by(|a, b| b.1.cmp(&a.1));

        let mut room_ids = BTreeSet::new();
        let mut result = vec![-1; queries.len()];
        let mut i = 0;

        for (preferred, min_size, idx) in queries_with_index {
            while i < rooms.len() && rooms[i][1] >= min_size {
                room_ids.insert(rooms[i][0]);
                i += 1;
            }

            if room_ids.is_empty() {
                continue;
            }

            let mut candidate = -1;
            if let Some(&floor) = room_ids.range(..=preferred).next_back() {
                candidate = floor;
            }
            if let Some(&ceil) = room_ids.range(preferred..).next() {
                if candidate == -1 || (ceil - preferred).abs() < (preferred - candidate).abs() {
                    candidate = ceil;
                }
            }
            result[idx] = candidate;
        }

        result
    }
}