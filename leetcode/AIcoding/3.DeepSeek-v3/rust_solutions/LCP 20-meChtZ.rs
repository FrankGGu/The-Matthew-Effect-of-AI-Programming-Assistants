use std::collections::{BinaryHeap, HashMap};

#[derive(Eq, PartialEq)]
struct State {
    cost: i32,
    pos: i32,
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
    pub fn bus_rapid_transit(target: i32, inc: i32, dec: i32, jump: Vec<i32>, cost: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut dist = HashMap::new();
        heap.push(State { cost: 0, pos: target });
        dist.insert(target, 0);
        let modulo = 1_000_000_007;

        while let Some(State { cost: current_cost, pos: current_pos }) = heap.pop() {
            if current_pos == 0 {
                return current_cost % modulo;
            }
            if current_cost > *dist.get(&current_pos).unwrap_or(&i32::MAX) {
                continue;
            }
            let next_cost = current_cost + inc * current_pos;
            if next_cost < *dist.get(&0).unwrap_or(&i32::MAX) {
                dist.insert(0, next_cost);
                heap.push(State { cost: next_cost, pos: 0 });
            }
            for (&j, &c) in jump.iter().zip(cost.iter()) {
                let next_pos = current_pos / j;
                let remainder = current_pos % j;
                if remainder == 0 {
                    let next_cost = current_cost + c;
                    if next_cost < *dist.get(&next_pos).unwrap_or(&i32::MAX) {
                        dist.insert(next_pos, next_cost);
                        heap.push(State { cost: next_cost, pos: next_pos });
                    }
                } else {
                    let next_cost1 = current_cost + c + remainder * inc;
                    if next_cost1 < *dist.get(&next_pos).unwrap_or(&i32::MAX) {
                        dist.insert(next_pos, next_cost1);
                        heap.push(State { cost: next_cost1, pos: next_pos });
                    }
                    let next_pos2 = next_pos + 1;
                    let next_cost2 = current_cost + c + (j - remainder) * dec;
                    if next_cost2 < *dist.get(&next_pos2).unwrap_or(&i32::MAX) {
                        dist.insert(next_pos2, next_cost2);
                        heap.push(State { cost: next_cost2, pos: next_pos2 });
                    }
                }
            }
        }
        -1
    }
}