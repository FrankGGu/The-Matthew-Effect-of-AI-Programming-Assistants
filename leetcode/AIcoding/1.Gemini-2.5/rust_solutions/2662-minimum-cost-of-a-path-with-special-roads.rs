use std::collections::{BinaryHeap, HashMap, HashSet};
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_cost(start: Vec<i32>, target: Vec<i32>, special_roads: Vec<Vec<i32>>) -> i32 {
        let mut points_set: HashSet<(i32, i32)> = HashSet::new();
        points_set.insert((start[0], start[1]));
        points_set.insert((target[0], target[1]));

        for road in &special_roads {
            points_set.insert((road[0], road[1]));
            points_set.insert((road[2], road[3]));
        }

        let id_to_coord: Vec<(i32, i32)> = points_set.into_iter().collect();

        let mut coord_to_id: HashMap<(i32, i32), usize> = HashMap::new();
        for (id, &coord) in id_to_coord.iter().enumerate() {
            coord_to_id.insert(coord, id);
        }

        let num_nodes = id_to_coord.len();
        let start_id = *coord_to_id.get(&(start[0], start[1])).unwrap();
        let target_id = *coord_to_id.get(&(target[0], target[1])).unwrap();

        let mut dist: Vec<i32> = vec![i32::MAX; num_nodes];
        dist[start_id] = 0;

        let mut pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();
        pq.push(Reverse((0, start_id)));

        while let Some(Reverse((d, u_id))) = pq.pop() {
            if d > dist[u_id] {
                continue;
            }

            let u_coord = id_to_coord[u_id];

            for v_id in 0..num_nodes {
                if u_id == v_id {
                    continue;
                }
                let v_coord = id_to_coord[v_id];
                let direct_cost = (u_coord.0 - v_coord.0).abs() + (u_coord.1 - v_coord.1).abs();

                if dist[u_id] != i32::MAX && dist[u_id] + direct_cost < dist[v_id] {
                    dist[v_id] = dist[u_id] + direct_cost;
                    pq.push(Reverse((dist[v_id], v_id)));
                }
            }

            for road in &special_roads {
                let sx1 = road[0];
                let sy1 = road[1];
                let sx2 = road[2];
                let sy2 = road[3];
                let special_cost = road[4];

                if sx1 == u_coord.0 && sy1 == u_coord.1 {
                    let v_id = *coord_to_id.get(&(sx2, sy2)).unwrap();
                    if dist[u_id] != i32::MAX && dist[u_id] + special_cost < dist[v_id] {
                        dist[v_id] = dist[u_id] + special_cost;
                        pq.push(Reverse((dist[v_id], v_id)));
                    }
                }
            }
        }

        dist[target_id]
    }
}