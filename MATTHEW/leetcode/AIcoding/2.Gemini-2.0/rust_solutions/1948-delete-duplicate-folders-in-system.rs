use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn delete_duplicate_folder(paths: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut id_map: HashMap<String, i32> = HashMap::new();
        let mut id_counter = 0;

        for path in &paths {
            let mut current = String::new();
            for folder in path {
                let next = if current.is_empty() {
                    folder.clone()
                } else {
                    format!("{}/{}", current, folder)
                };

                graph.entry(current.clone()).or_insert(Vec::new()).push(next.clone());
                current = next;
            }
        }

        fn compute_signature(
            node: &String,
            graph: &HashMap<String, Vec<String>>,
            id_map: &mut HashMap<String, i32>,
            id_counter: &mut i32,
            signatures: &mut HashMap<String, String>,
        ) -> String {
            if let Some(sig) = signatures.get(node) {
                return sig.clone();
            }

            let children = graph.get(node).unwrap_or(&Vec::new());
            if children.is_empty() {
                let id = *id_counter;
                *id_counter += 1;
                id_map.insert(node.clone(), id);
                let signature = format!("({})", node);
                signatures.insert(node.clone(), signature.clone());
                return signature;
            }

            let mut child_signatures: Vec<String> = children
                .iter()
                .map(|child| compute_signature(child, graph, id_map, id_counter, signatures))
                .collect();
            child_signatures.sort();

            let mut signature = format!("({})", node);
            for child_signature in child_signatures {
                signature.push_str(&child_signature);
            }
            signatures.insert(node.clone(), signature.clone());
            signature
        }

        let mut signatures: HashMap<String, String> = HashMap::new();
        compute_signature(&String::new(), &graph, &mut id_map, &mut id_counter, &mut signatures);

        let mut signature_to_nodes: HashMap<String, Vec<String>> = HashMap::new();
        for (node, signature) in &signatures {
            signature_to_nodes.entry(signature.clone()).or_insert(Vec::new()).push(node.clone());
        }

        let mut to_delete: HashSet<String> = HashSet::new();
        for (_, nodes) in &signature_to_nodes {
            if nodes.len() > 1 {
                for node in nodes {
                    if !node.is_empty() {
                        to_delete.insert(node.clone());
                    }
                }
            }
        }

        let mut result: Vec<Vec<String>> = Vec::new();

        fn build_path(node: &String) -> Vec<String> {
            let mut path = Vec::new();
            let parts: Vec<&str> = node.split('/').collect();
            for part in parts {
                if !part.is_empty() {
                    path.push(part.to_string());
                }
            }
            path
        }

        for path in &paths {
            let mut current = String::new();
            let mut should_add = true;
            for folder in path {
                let next = if current.is_empty() {
                    folder.clone()
                } else {
                    format!("{}/{}", current, folder)
                };
                if to_delete.contains(&next) {
                    should_add = false;
                    break;
                }
                current = next;
            }
            if should_add {
                result.push(path.clone());
            }
        }

        result.sort();
        result
    }
}