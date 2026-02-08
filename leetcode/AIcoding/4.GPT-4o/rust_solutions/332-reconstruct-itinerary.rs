use std::collections::{HashMap, VecDeque};

pub fn find_itinerary(tickets: Vec<Vec<String>>) -> Vec<String> {
    let mut graph = HashMap::new();
    for ticket in tickets {
        graph.entry(ticket[0].clone()).or_insert_with(Vec::new).push(ticket[1].clone());
    }

    for destinations in graph.values_mut() {
        destinations.sort();
    }

    let mut result = Vec::new();
    let mut stack = VecDeque::new();
    stack.push_back("JFK".to_string());

    while let Some(node) = stack.back() {
        if let Some(destinations) = graph.get_mut(node) {
            if !destinations.is_empty() {
                stack.push_back(destinations.remove(0));
            } else {
                result.push(stack.pop_back().unwrap());
            }
        } else {
            result.push(stack.pop_back().unwrap());
        }
    }

    result.reverse();
    result
}