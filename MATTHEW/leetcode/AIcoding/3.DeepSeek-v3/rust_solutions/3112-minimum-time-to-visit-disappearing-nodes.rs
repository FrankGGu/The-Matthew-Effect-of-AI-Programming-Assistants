use std::collections::{BinaryHeap, HashMap};

#[derive(PartialEq, Eq)]
struct State {
    time: i32,
    node: i32,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.time.cmp(&self.time)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn minimum_time(n: i32, edges: Vec<Vec<i32>>, disappear: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            let t = edge[2];
            graph.entry(u).or_default().push((v, t));
            graph.entry(v).or_default().push((u, t));
        }

        let mut dist = vec![-1; n];
        let mut heap = BinaryHeap::new();
        heap.push(State { time: 0, node: 0 });

        while let Some(State { time, node }) = heap.pop() {
            if dist[node as usize] != -1 {
                continue;
            }
            dist[node as usize] = time;
            if let Some(neighbors) = graph.get(&node) {
                for &(next_node, next_time) in neighbors {
                    let new_time = time + next_time;
                    if new_time < disappear[next_node as usize] && dist[next_node as usize] == -1 {
                        heap.push(State {
                            time: new_time,
                            node: next_node,
                        });
                    }
                }
            }
        }

        dist
    }
}