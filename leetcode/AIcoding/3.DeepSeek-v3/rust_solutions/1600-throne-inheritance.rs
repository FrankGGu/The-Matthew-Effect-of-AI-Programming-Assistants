use std::collections::HashMap;
use std::collections::HashSet;

struct ThroneInheritance {
    king: String,
    children: HashMap<String, Vec<String>>,
    dead: HashSet<String>,
}

impl ThroneInheritance {
    fn new(king_name: String) -> Self {
        let mut children = HashMap::new();
        children.insert(king_name.clone(), Vec::new());
        ThroneInheritance {
            king: king_name,
            children,
            dead: HashSet::new(),
        }
    }

    fn birth(&mut self, parent_name: String, child_name: String) {
        self.children.entry(parent_name).or_insert(Vec::new()).push(child_name);
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
        if let Some(children) = self.children.get(name) {
            for child in children {
                self.dfs(child, order);
            }
        }
    }
}