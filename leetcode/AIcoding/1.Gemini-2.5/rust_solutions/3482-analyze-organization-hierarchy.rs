use std::collections::HashMap;

impl Solution {
    pub fn analyze_organization_hierarchy(employees: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut direct_reports_count: HashMap<i32, i32> = HashMap::new();

        for employee in employees {
            let manager_id = employee[1];
            if manager_id != 0 {
                *direct_reports_count.entry(manager_id).or_insert(0) += 1;
            }
        }

        let mut result: Vec<Vec<i32>> = direct_reports_count
            .into_iter()
            .map(|(manager_id, count)| vec![manager_id, count])
            .collect();

        result.sort_unstable_by_key(|v| v[0]);

        result
    }
}