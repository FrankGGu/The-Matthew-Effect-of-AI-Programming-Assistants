impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn min_fuel_cost(n: i32, mut roads: Vec<Vec<i32>>, mut seats: i32) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for road in &roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut fuel = 0;
        let mut visited = vec![false; n];
        let mut stack = vec![(0, -1)];

        while let Some((node, parent)) = stack.pop() {
            visited[node] = true;
            let mut passengers = 1;

            for &neighbor in &graph[node] {
                if neighbor != parent {
                    stack.push((neighbor, node as i32));
                }
            }

            if parent != -1 {
                passengers = 1;
                for &neighbor in &graph[node] {
                    if neighbor != parent {
                        passengers += visited[neighbor] as i32;
                    }
                }

                let cars = (passengers + seats - 1) / seats;
                fuel += cars;
            }
        }

        fuel
    }
}
}