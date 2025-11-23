use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn analyze_hierarchy(employees: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut in_degree: HashMap<String, i32> = HashMap::new();
        let mut all_employees: Vec<String> = Vec::new();

        for emp in &employees {
            let name = &emp[0];
            let manager = &emp[1];
            graph.entry(manager.clone()).or_default().push(name.clone());
            in_degree.entry(name.clone()).or_insert(0);
            in_degree.entry(manager.clone()).or_insert(0);
            if manager != "NULL" {
                *in_degree.get_mut(name).unwrap() += 1;
            }
            if !all_employees.contains(name) {
                all_employees.push(name.clone());
            }
            if !all_employees.contains(manager) && manager != "NULL" {
                all_employees.push(manager.clone());
            }
        }

        let mut roots = Vec::new();
        for emp in &all_employees {
            if *in_degree.get(emp).unwrap() == 0 {
                roots.push(emp.clone());
            }
        }

        let mut result = Vec::new();
        for root in roots {
            let mut stack = vec![(root.clone(), 0)];
            let mut max_depth = 0;
            let mut count_at_depth: HashMap<i32, i32> = HashMap::new();
            let mut total_at_depth: HashMap<i32, i32> = HashMap::new();

            while let Some((current, depth)) = stack.pop() {
                max_depth = max_depth.max(depth);
                *count_at_depth.entry(depth).or_default() += 1;
                if let Some(subordinates) = graph.get(&current) {
                    for sub in subordinates {
                        stack.push((sub.clone(), depth + 1));
                    }
                }
            }

            for depth in 0..=max_depth {
                let count = *count_at_depth.get(&depth).unwrap_or(&0);
                *total_at_depth.entry(depth).or_default() += count;
            }

            for depth in 0..=max_depth {
                let count = *count_at_depth.get(&depth).unwrap_or(&0);
                let total = *total_at_depth.get(&depth).unwrap_or(&0);
                let percentage = if total == 0 {
                    0.0
                } else {
                    (count as f64 / total as f64) * 100.0
                };
                result.push(vec![
                    root.clone(),
                    depth.to_string(),
                    format!("{:.2}%", percentage),
                ]);
            }
        }

        result
    }
}