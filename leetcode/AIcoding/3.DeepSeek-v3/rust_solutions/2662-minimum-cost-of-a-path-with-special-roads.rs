use std::collections::{BinaryHeap, HashMap};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn new(x: i32, y: i32) -> Self {
        Point { x, y }
    }

    fn manhattan(&self, other: &Point) -> i32 {
        (self.x - other.x).abs() + (self.y - other.y).abs()
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct State {
    cost: i32,
    point: Point,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn minimum_cost(start: Vec<i32>, target: Vec<i32>, special_roads: Vec<Vec<i32>>) -> i32 {
        let start_point = Point::new(start[0], start[1]);
        let target_point = Point::new(target[0], target[1]);
        let mut special_roads_map: HashMap<(Point, Point), i32> = HashMap::new();

        for road in special_roads {
            let from = Point::new(road[0], road[1]);
            let to = Point::new(road[2], road[3]);
            let cost = road[4];
            special_roads_map.entry((from, to))
                .and_modify(|e| *e = (*e).min(cost))
                .or_insert(cost);
        }

        let mut heap = BinaryHeap::new();
        let mut dist = HashMap::new();
        heap.push(State { cost: 0, point: start_point });
        dist.insert(start_point, 0);

        while let Some(State { cost, point }) = heap.pop() {
            if point == target_point {
                return cost;
            }

            if cost > *dist.get(&point).unwrap_or(&i32::MAX) {
                continue;
            }

            let direct_cost = cost + point.manhattan(&target_point);
            if direct_cost < *dist.get(&target_point).unwrap_or(&i32::MAX) {
                dist.insert(target_point, direct_cost);
                heap.push(State { cost: direct_cost, point: target_point });
            }

            for (&(from, to), &road_cost) in special_roads_map.iter() {
                if from == point {
                    let new_cost = cost + road_cost;
                    if new_cost < *dist.get(&to).unwrap_or(&i32::MAX) {
                        dist.insert(to, new_cost);
                        heap.push(State { cost: new_cost, point: to });
                    }
                }
            }
        }

        *dist.get(&target_point).unwrap()
    }
}