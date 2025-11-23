use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_itinerary(tickets: Vec<Vec<String>>) -> Vec<String> {
        let mut adj: HashMap<String, Vec<String>> = HashMap::new();

        for ticket in tickets {
            adj.entry(ticket[0].clone())
                .or_insert_with(Vec::new)
                .push(ticket[1].clone());
        }

        for destinations in adj.values_mut() {
            // Sort destinations in reverse lexicographical order
            // so that `pop()` gives the lexicographically smallest destination.
            destinations.sort_unstable_by(|a, b| b.cmp(a));
        }

        let mut path: Vec<String> = Vec::new();

        Self::dfs("JFK".to_string(), &mut adj, &mut path);

        // The path is built in reverse order, so reverse it at the end.
        path.reverse();
        path
    }

    fn dfs(airport: String, adj: &mut HashMap<String, Vec<String>>, path: &mut Vec<String>) {
        // While there are outgoing flights from the current airport
        while let Some(next_airport) = adj.get_mut(&airport).and_then(|destinations| destinations.pop()) {
            Self::dfs(next_airport, adj, path);
        }
        // Add the current airport to the path after all its outgoing flights have been explored.
        path.push(airport);
    }
}