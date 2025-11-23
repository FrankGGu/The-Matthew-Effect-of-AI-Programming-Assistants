use std::collections::BinaryHeap;

pub fn find_cheapest_price(n: i32, flights: Vec<Vec<i32>>, src: i32, dst: i32, k: i32) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    for flight in flights {
        graph[flight[0] as usize].push((flight[1], flight[2]));
    }

    let mut dist = vec![std::i32::MAX; n as usize];
    dist[src as usize] = 0;

    let mut heap = BinaryHeap::new();
    heap.push((0, src, 0)); // (cost, node, stops)

    while let Some((cost, node, stops)) = heap.pop() {
        let cost = -cost;
        if node == dst {
            return cost;
        }
        if stops > k {
            continue;
        }
        for &(next_node, price) in &graph[node as usize] {
            let new_cost = cost + price;
            if new_cost < dist[next_node as usize] {
                dist[next_node as usize] = new_cost;
                heap.push((-new_cost, next_node, stops + 1));
            }
        }
    }

    if dist[dst as usize] == std::i32::MAX {
        -1
    } else {
        dist[dst as usize]
    }
}