use std::collections::{HashMap, HashSet};

pub fn accounts_merge(accounts: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut email_to_name = HashMap::new();
    let mut graph = HashMap::new();

    for account in accounts {
        let name = account[0].clone();
        for email in &account[1..] {
            email_to_name.insert(email.clone(), name.clone());
            graph.entry(email.clone()).or_insert_with(HashSet::new);
        }
        for i in 1..account.len() {
            graph.entry(account[i].clone()).or_insert_with(HashSet::new).insert(account[i - 1].clone());
            graph.entry(account[i - 1].clone()).or_insert_with(HashSet::new).insert(account[i].clone());
        }
    }

    let mut visited = HashSet::new();
    let mut result = Vec::new();

    for email in graph.keys() {
        if !visited.contains(email) {
            let mut emails = Vec::new();
            dfs(email, &graph, &mut visited, &mut emails);
            emails.sort();
            let mut merged_account = vec![email_to_name[email].clone()];
            merged_account.extend(emails);
            result.push(merged_account);
        }
    }

    result
}

fn dfs(email: &String, graph: &HashMap<String, HashSet<String>>, visited: &mut HashSet<String>, emails: &mut Vec<String>) {
    visited.insert(email.clone());
    emails.push(email.clone());
    if let Some(neighbors) = graph.get(email) {
        for neighbor in neighbors {
            if !visited.contains(neighbor) {
                dfs(neighbor, graph, visited, emails);
            }
        }
    }
}