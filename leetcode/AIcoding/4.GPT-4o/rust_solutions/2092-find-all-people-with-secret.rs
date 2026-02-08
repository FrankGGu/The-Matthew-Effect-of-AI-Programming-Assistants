use std::collections::{HashMap, HashSet};

pub fn find_all_people(n: i32, meetings: Vec<Vec<i32>>, first_person: i32) -> Vec<i32> {
    let mut adj: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
    let mut people_with_secret = HashSet::new();
    people_with_secret.insert(0);
    people_with_secret.insert(first_person);

    for meeting in meetings {
        let (x, y, time) = (meeting[0], meeting[1], meeting[2]);
        adj.entry(x).or_insert(vec![]).push((y, time));
        adj.entry(y).or_insert(vec![]).push((x, time));
    }

    let mut visited = HashSet::new();

    fn dfs(person: i32, time: i32, adj: &HashMap<i32, Vec<(i32, i32)>>, visited: &mut HashSet<i32>, people_with_secret: &mut HashSet<i32>) {
        if visited.contains(&person) {
            return;
        }
        visited.insert(person);
        if people_with_secret.contains(&person) {
            people_with_secret.insert(person);
        }
        if let Some(neighbors) = adj.get(&person) {
            for &(neighbor, t) in neighbors {
                if !visited.contains(&neighbor) {
                    dfs(neighbor, t, adj, visited, people_with_secret);
                }
            }
        }
    }

    let mut times: Vec<(i32, Vec<i32>)> = meetings.iter().cloned().collect();
    times.sort_by(|a, b| a[2].cmp(&b[2]));

    let mut idx = 0;
    while idx < times.len() {
        let current_time = times[idx][2];
        let mut group = vec![];

        while idx < times.len() && times[idx][2] == current_time {
            group.push(times[idx][0]);
            group.push(times[idx][1]);
            idx += 1;
        }

        let mut current_people_with_secret = people_with_secret.clone();
        for &person in &group {
            if current_people_with_secret.contains(&person) {
                dfs(person, current_time, &adj, &mut visited, &mut current_people_with_secret);
            }
        }

        if current_people_with_secret.len() > 0 {
            for &person in &group {
                if current_people_with_secret.contains(&person) {
                    people_with_secret.insert(person);
                }
            }
        }
    }

    people_with_secret.into_iter().collect()
}