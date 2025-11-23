use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct State {
    cost: i32,
    node: usize,
    fuel: i32,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn electric_car_plan(paths: Vec<Vec<i32>>, cnt: i32, start: i32, end: i32, charge: Vec<i32>) -> i32 {
        let n = charge.len();
        let start = start as usize;
        let end = end as usize;
        let cnt = cnt as usize;

        let mut adj = vec![vec![]; n];
        for path in paths {
            let u = path[0] as usize;
            let v = path[1] as usize;
            let w = path[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist = vec![vec![i32::MAX; cnt + 1]; n];
        dist[start][0] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(State { cost: 0, node: start, fuel: 0 });

        while let Some(State { cost, node, fuel }) = heap.pop() {
            if node == end {
                return cost;
            }
            if cost > dist[node][fuel as usize] {
                continue;
            }

            if fuel < cnt as i32 {
                let new_fuel = fuel + 1;
                let new_cost = cost + charge[node];
                if new_cost < dist[node][new_fuel as usize] {
                    dist[node][new_fuel as usize] = new_cost;
                    heap.push(State { cost: new_cost, node, fuel: new_fuel });
                }
            }

            for &(neighbor, weight) in &adj[node] {
                if fuel >= weight {
                    let new_fuel = fuel - weight;
                    if dist[neighbor][new_fuel as usize] > cost + weight {
                        dist[neighbor][new_fuel as usize] = cost + weight;
                        heap.push(State { cost: cost + weight, node: neighbor, fuel: new_fuel });
                    }
                }
            }
        }

        -1
    }
}