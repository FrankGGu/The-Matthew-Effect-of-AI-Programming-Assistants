use std::collections::{HashMap, HashSet, BinaryHeap};
use std::cmp::Ordering;

struct Graph {
    edges: HashMap<i32, Vec<(i32, i32)>>,
}

impl Graph {
    fn new() -> Self {
        Graph {
            edges: HashMap::new(),
        }
    }

    fn add_edge(&mut self, u: i32, v: i32, w: i32) {
        self.edges.entry(u).or_insert(Vec::new()).push((v, w));
        self.edges.entry(v).or_insert(Vec::new()).push((u, w));
    }

    fn shortest_path(&self, start: i32, end: i32) -> i32 {
        let mut dist = HashMap::new();
        let mut heap = BinaryHeap::new();
        dist.insert(start, 0);
        heap.push(State { cost: 0, node: start });

        while let Some(State { cost, node }) = heap.pop() {
            if node == end {
                return cost;
            }
            if cost > *dist.get(&node).unwrap_or(&i32::MAX) {
                continue;
            }
            if let Some(neighbors) = self.edges.get(&node) {
                for &(neighbor, weight) in neighbors {
                    let next = State { cost: cost + weight, node: neighbor };
                    if next.cost < *dist.get(&neighbor).unwrap_or(&i32::MAX) {
                        dist.insert(neighbor, next.cost);
                        heap.push(next);
                    }
                }
            }
        }
        -1
    }
}

#[derive(Eq, PartialEq)]
struct State {
    cost: i32,
    node: i32,
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

struct ShortestPathCalculator {
    graph: Graph,
}

impl ShortestPathCalculator {
    fn new() -> Self {
        ShortestPathCalculator {
            graph: Graph::new(),
        }
    }

    fn add_edge(&mut self, u: i32, v: i32, w: i32) {
        self.graph.add_edge(u, v, w);
    }

    fn shortest_path(&self, start: i32, end: i32) -> i32 {
        self.graph.shortest_path(start, end)
    }
}