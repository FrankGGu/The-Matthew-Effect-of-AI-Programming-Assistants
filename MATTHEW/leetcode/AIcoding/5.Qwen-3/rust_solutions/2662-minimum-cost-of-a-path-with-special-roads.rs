impl Solution {

use std::collections::{BinaryHeap, HashMap};

#[derive(Copy, Clone, PartialEq, Eq, Hash, Debug)]
struct Point(i32, i32);

#[derive(Copy, Clone, PartialEq, Eq, Hash)]
struct State(i32, i32, i32);

impl Solution {
    pub fn minimum_cost(
        width: i32,
        height: i32,
        _travels: Vec<Vec<i32>>,
        special_roads: Vec<Vec<i32>>,
    ) -> i32 {
        let mut graph = HashMap::new();
        for road in &special_roads {
            let x1 = road[0];
            let y1 = road[1];
            let x2 = road[2];
            let y2 = road[3];
            let cost = road[4];
            graph.entry((x1, y1)).or_insert_with(Vec::new).push((x2, y2, cost));
            graph.entry((x2, y2)).or_insert_with(Vec::new).push((x1, y1, cost));
        }

        let start = Point(0, 0);
        let end = Point(width - 1, height - 1);

        let mut dist = HashMap::new();
        dist.insert(start, 0);

        let mut heap = BinaryHeap::new();
        heap.push(State(0, 0, 0));

        while let Some(State(d, x, y)) = heap.pop() {
            if Point(x, y) == end {
                return d;
            }
            if d > *dist.get(&Point(x, y)).unwrap_or(&i32::MAX) {
                continue;
            }

            for (nx, ny, cost) in &graph[&Point(x, y)] {
                let nd = d + cost;
                if nd < *dist.get(&Point(*nx, *ny)).unwrap_or(&i32::MAX) {
                    dist.insert(Point(*nx, *ny), nd);
                    heap.push(State(nd, *nx, *ny));
                }
            }

            for (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && ny >= 0 && nx < width && ny < height {
                    let nd = d + 1;
                    if nd < *dist.get(&Point(nx, ny)).unwrap_or(&i32::MAX) {
                        dist.insert(Point(nx, ny), nd);
                        heap.push(State(nd, nx, ny));
                    }
                }
            }
        }

        -1
    }
}
}