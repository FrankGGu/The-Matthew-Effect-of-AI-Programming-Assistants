impl Solution {
    pub fn find_itinerary(tickets: Vec<Vec<String>>) -> Vec<String> {
        use std::collections::HashMap;
        use std::collections::BinaryHeap;
        use std::cmp::Reverse;

        let mut graph: HashMap<String, BinaryHeap<Reverse<String>>> = HashMap::new();
        for ticket in tickets {
            let from = ticket[0].clone();
            let to = ticket[1].clone();
            graph.entry(from).or_insert(BinaryHeap::new()).push(Reverse(to));
        }

        let mut itinerary: Vec<String> = Vec::new();
        let mut stack: Vec<String> = Vec::new();
        stack.push("JFK".to_string());

        while let Some(current) = stack.last().cloned() {
            if let Some(heap) = graph.get_mut(&current) {
                if !heap.is_empty() {
                    if let Some(Reverse(next)) = heap.pop() {
                        stack.push(next);
                    }
                } else {
                    itinerary.push(stack.pop().unwrap());
                }
            } else {
                itinerary.push(stack.pop().unwrap());
            }
        }

        itinerary.reverse();
        itinerary
    }
}