use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_cost(start: Vec<i32>, target: Vec<i32>, special_roads: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;

        let mut graph: HashMap<(i32, i32), Vec<((i32, i32), i32)>> = HashMap::new();

        let mut points = vec![start.clone(), target.clone()];
        for road in &special_roads {
            points.push(vec![road[0], road[1]]);
            points.push(vec![road[2], road[3]]);
        }

        for i in 0..points.len() {
            for j in 0..points.len() {
                if i == j {
                    continue;
                }
                let p1 = (points[i][0], points[i][1]);
                let p2 = (points[j][0], points[j][1]);
                let cost = (points[i][0] - points[j][0]).abs() + (points[i][1] - points[j][1]).abs();
                graph.entry(p1).or_insert(vec![]).push((p2, cost));
            }
        }

        for road in &special_roads {
            let p1 = (road[0], road[1]);
            let p2 = (road[2], road[3]);
            graph.entry(p1).or_insert(vec![]).push((p2, road[4]));
        }

        let start_node = (start[0], start[1]);
        let target_node = (target[0], target[1]);

        let mut dist: HashMap<(i32, i32), i32> = HashMap::new();
        dist.insert(start_node, 0);

        let mut pq: BinaryHeap<(Reverse<i32>, (i32, i32))> = BinaryHeap::new();
        pq.push((Reverse(0), start_node));

        while let Some((Reverse(d), u)) = pq.pop() {
            if d > *dist.get(&u).unwrap_or(&i32::MAX) {
                continue;
            }

            if let Some(neighbors) = graph.get(&u) {
                for &(v, weight) in neighbors {
                    let new_dist = d + weight;
                    if new_dist < *dist.get(&v).unwrap_or(&i32::MAX) {
                        dist.insert(v, new_dist);
                        pq.push((Reverse(new_dist), v));
                    }
                }
            }
        }

        *dist.get(&target_node).unwrap_or(&i32::MAX)
    }
}