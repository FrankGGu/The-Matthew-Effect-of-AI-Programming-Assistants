use std::collections::{HashMap, HashSet};

struct ThroneInheritance {
    king: String,
    family_tree: HashMap<String, Vec<String>>,
    dead: HashSet<String>,
}

impl ThroneInheritance {
    fn new(king_name: String) -> Self {
        let mut family_tree = HashMap::new();
        family_tree.insert(king_name.clone(), Vec::new());
        ThroneInheritance {
            king: king_name,
            family_tree,
            dead: HashSet::new(),
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
        self.dfs_inheritance(&self.king, &mut order);
        order
    }

    fn dfs_inheritance(&self, current_person: &String, order: &mut Vec<String>) {
        if !self.dead.contains(current_person) {
            order.push(current_person.clone());
        }

        if let Some(children) = self.family_tree.get(current_person) {
            for child in children {
                self.dfs_inheritance(child, order);
            }
        }
    }
}