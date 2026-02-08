use std::collections::HashMap;

struct ThroneInheritance {
    king: String,
    family_tree: HashMap<String, Vec<String>>,
    dead: std::collections::HashSet<String>,
}

impl ThroneInheritance {
    fn new(king_name: String) -> Self {
        ThroneInheritance {
            king: king_name,
            family_tree: HashMap::new(),
            dead: std::collections::HashSet::new(),
        }
    }

    fn birth(&mut self, parent_name: String, child_name: String) {
        self.family_tree.entry(parent_name).or_default().push(child_name);
    }

    fn death(&mut self, name: String) {
        self.dead.insert(name);
    }

    fn get_inheritance_order(&self) -> Vec<String> {
        let mut order = Vec::new();
        self.dfs(&self.king, &mut order);
        order
    }

    fn dfs(&self, name: &String, order: &mut Vec<String>) {
        if !self.dead.contains(name) {
            order.push(name.clone());
        }
        if let Some(children) = self.family_tree.get(name) {
            for child in children {
                self.dfs(child, order);
            }
        }
    }
}