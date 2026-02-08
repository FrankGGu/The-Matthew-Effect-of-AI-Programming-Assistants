use std::collections::BinaryHeap;
use std::cmp::Ordering;

pub struct SpecialRoad {
    x: i32,
    y: i32,
    cost: i32,
}

impl PartialEq for SpecialRoad {
    fn eq(&self, other: &Self) -> bool {
        self.cost == other.cost
    }
}

impl Eq for SpecialRoad {}

impl Ord for SpecialRoad {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for SpecialRoad {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

pub fn minimum_cost(n: i32, connections: Vec<Vec<i32>>) -> i32 {
    let mut graph: Vec<Vec<(i32, i32)>> = vec![vec![]; n as usize];
    for conn in connections {
        graph[conn[0] as usize].push((conn[1], conn[2]));
        graph[conn[1] as usize].push((conn[0], conn[2]));
    }

    let mut dist = vec![i32::MAX; n as usize];
    dist[0] = 0;
    let mut heap = BinaryHeap::new();
    heap.push(SpecialRoad { x: 0, y: 0, cost: 0 });

    while let Some(SpecialRoad { x, cost, .. }) = heap.pop() {
        if cost > dist[x as usize] {
            continue;
        }

        for &(neighbor, weight) in &graph[x as usize] {
            let next_cost = cost + weight;
            if next_cost < dist[neighbor as usize] {
                dist[neighbor as usize] = next_cost;
                heap.push(SpecialRoad { x: neighbor, y: 0, cost: next_cost });
            }
        }
    }

    if dist[n as usize - 1] == i32::MAX {
        -1
    } else {
        dist[n as usize - 1]
    }
}