use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn find_itinerary(tickets: Vec<Vec<String>>) -> Vec<String> {
        let mut graph: HashMap<String, BinaryHeap<Reverse<String>>> = HashMap::new();
        for ticket in tickets {
            let from = ticket[0].clone();
            let to = ticket[1].clone();
            graph.entry(from).or_insert(BinaryHeap::new()).push(Reverse(to));
        }

        let mut stack: Vec<String> = Vec::new();
        let mut itinerary: Vec<String> = Vec::new();
        stack.push("JFK".to_string());

        while let Some(node) = stack.last() {
            if let Some(edges) = graph.get_mut(node) {
                if !edges.is_empty() {
                    if let Some(Reverse(next)) = edges.pop() {
                        stack.push(next);
                    }
                    continue;
                }
            }
            if let Some(last) = stack.pop() {
                itinerary.push(last);
            }
        }

        itinerary.into_iter().rev().collect()
    }
}