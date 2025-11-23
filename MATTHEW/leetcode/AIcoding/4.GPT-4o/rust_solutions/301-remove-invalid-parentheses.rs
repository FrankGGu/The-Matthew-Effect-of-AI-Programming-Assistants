use std::collections::HashSet;

pub fn remove_invalid_parentheses(s: String) -> Vec<String> {
    let mut res = Vec::new();
    let mut visited = HashSet::new();
    let mut queue = vec![s];
    let mut found = false;

    while !queue.is_empty() {
        let current = queue.remove(0);
        if is_valid(&current) {
            res.push(current.clone());
            found = true;
        }
        if found { continue; }

        for i in 0..current.len() {
            if current.chars().nth(i).unwrap() == '(' || current.chars().nth(i).unwrap() == ')' {
                let next = current[0..i].to_string() + &current[i + 1..];
                if !visited.contains(&next) {
                    visited.insert(next.clone());
                    queue.push(next);
                }
            }
        }
    }
    res
}

fn is_valid(s: &str) -> bool {
    let mut balance = 0;
    for c in s.chars() {
        if c == '(' {
            balance += 1;
        } else if c == ')' {
            balance -= 1;
        }
        if balance < 0 {
            return false;
        }
    }
    balance == 0
}