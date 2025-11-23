use std::collections::HashSet;

impl Solution {
    pub fn find_all_people(n: i32, meetings: Vec<Vec<i32>>, first_person: i32) -> Vec<i32> {
        let mut adj: Vec<Vec<(i32, i32)>> = vec![vec![]; n as usize];
        for meeting in &meetings {
            adj[meeting[0] as usize].push((meeting[1], meeting[2]));
            adj[meeting[1] as usize].push((meeting[0], meeting[2]));
        }

        let mut known: HashSet<i32> = HashSet::new();
        known.insert(0);
        known.insert(first_person);

        let mut time_slices: std::collections::BTreeMap<i32, Vec<(i32, i32)>> = std::collections::BTreeMap::new();
        for i in 0..n {
            for &(person2, time) in &adj[i as usize] {
                time_slices.entry(time).or_insert(vec![]).push((i, person2));
            }
        }

        for (_, meetings_at_time) in time_slices {
            let mut graph: std::collections::HashMap<i32, Vec<i32>> = std::collections::HashMap::new();
            let mut current_known: HashSet<i32> = HashSet::new();

            for &(p1, p2) in &meetings_at_time {
                graph.entry(p1).or_insert(vec![]).push(p2);
                graph.entry(p2).or_insert(vec![]).push(p1);
                if known.contains(&p1) {
                    current_known.insert(p1);
                }
                if known.contains(&p2) {
                    current_known.insert(p2);
                }
            }

            let mut q: Vec<i32> = current_known.into_iter().collect();
            let mut visited: HashSet<i32> = HashSet::new();

            while let Some(curr) = q.pop() {
                if visited.contains(&curr) {
                    continue;
                }
                visited.insert(curr);
                known.insert(curr);

                if let Some(neighbors) = graph.get(&curr) {
                    for &neighbor in neighbors {
                        if !visited.contains(&neighbor) {
                            q.push(neighbor);
                        }
                    }
                }
            }
        }

        known.into_iter().collect()
    }
}