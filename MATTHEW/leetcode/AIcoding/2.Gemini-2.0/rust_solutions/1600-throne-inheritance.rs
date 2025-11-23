use std::collections::{HashMap, HashSet};

struct ThroneInheritance {
    king: String,
    adj: HashMap<String, Vec<String>>,
    dead: HashSet<String>,
}

impl ThroneInheritance {
    fn new(king_name: String) -> Self {
        ThroneInheritance {
            king: king_name,
            adj: HashMap::new(),
            dead: HashSet::new(),
        }
    }

    fn birth(&mut self, parent_name: String, child_name: String) {
        self.adj.entry(parent_name).or_insert(Vec::new()).push(child_name);
    }

    fn death(&mut self, name: String) {
        self.dead.insert(name);
    }

    fn get_inheritance_order(&self) -> Vec<String> {
        let mut order = Vec::new();
        self.dfs(&self.king, &mut order);
        order
    }

    fn dfs(&self, node: &String, order: &mut Vec<String>) {
        if !self.dead.contains(node) {
            order.push(node.clone());
        }

        if let Some(children) = self.adj.get(node) {
            for child in children {
                self.dfs(child, order);
            }
        }
    }
}