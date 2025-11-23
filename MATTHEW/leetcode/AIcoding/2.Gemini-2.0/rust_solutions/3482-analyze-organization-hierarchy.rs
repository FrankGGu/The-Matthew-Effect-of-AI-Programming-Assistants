use std::collections::HashMap;

struct Node {
    id: i32,
    direct_reports: Vec<i32>,
    total_employees: i32,
}

impl Node {
    fn new(id: i32) -> Self {
        Node {
            id,
            direct_reports: Vec::new(),
            total_employees: 0,
        }
    }
}

impl Solution {
    pub fn total_number_of_employees(head_id: i32, employees: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph: HashMap<i32, Node> = HashMap::new();

        for employee in &employees {
            let id = employee[0];
            let manager_id = employee[1];

            graph.entry(id).or_insert(Node::new(id));
            graph.entry(manager_id).or_insert(Node::new(manager_id));

            graph.get_mut(&manager_id).unwrap().direct_reports.push(id);
        }

        fn dfs(node_id: i32, graph: &mut HashMap<i32, Node>) -> i32 {
            let mut total = 1;
            let direct_reports = graph.get(&node_id).unwrap().direct_reports.clone();

            for report_id in direct_reports {
                total += dfs(report_id, graph);
            }

            graph.get_mut(&node_id).unwrap().total_employees = total;
            total
        }

        dfs(head_id, &mut graph);

        let mut result: Vec<i32> = Vec::new();
        for employee in &employees {
            result.push(graph.get(&employee[0]).unwrap().direct_reports.len() as i32);
            result.push(graph.get(&employee[0]).unwrap().total_employees - 1);
        }

        result
    }
}