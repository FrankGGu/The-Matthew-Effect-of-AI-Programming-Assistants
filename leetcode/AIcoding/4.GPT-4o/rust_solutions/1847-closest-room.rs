use std::collections::HashMap;

pub fn closest_room(rooms: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut room_map: HashMap<i32, Vec<i32>> = HashMap::new();
    for (i, room) in rooms.iter().enumerate() {
        room_map.entry(room[1]).or_insert(vec![]).push(i as i32);
    }

    let mut results = vec![-1; queries.len()];
    let mut active_rooms = vec![];
    let mut idx_queries: Vec<_> = (0..queries.len()).collect();
    idx_queries.sort_by_key(|&i| queries[i][1]);

    let mut j = 0;
    for i in idx_queries {
        while j < rooms.len() && rooms[j][1] >= queries[i][1] {
            active_rooms.push(rooms[j][0]);
            j += 1;
        }

        active_rooms.sort_unstable();
        let target = queries[i][0];
        if let Ok(pos) = active_rooms.binary_search(&target) {
            results[i] = active_rooms[pos];
        } else {
            let pos = active_rooms.iter().position(|&x| x > target);
            if let Some(p) = pos {
                results[i] = active_rooms[p - 1];
            }
        }
    }

    results
}