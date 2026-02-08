use std::collections::{HashMap, HashSet};

struct UnionFind {
    parent: HashMap<String, String>,
    weight: HashMap<String, f64>,
}

impl UnionFind {
    fn new() -> Self {
        UnionFind {
            parent: HashMap::new(),
            weight: HashMap::new(),
        }
    }

    fn find(&mut self, node: String) -> String {
        if !self.parent.contains_key(&node) {
            self.parent.insert(node.clone(), node.clone());
            self.weight.insert(node.clone(), 1.0);
            return node;
        }
        let parent_node = self.parent[&node].clone();
        if parent_node == node {
            return node;
        }
        let root = self.find(parent_node);
        self.parent.insert(node.clone(), root.clone());
        let new_weight = self.weight[&node] * self.weight[&parent_node];
        self.weight.insert(node.clone(), new_weight);
        root
    }

    fn union(&mut self, a: String, b: String, value: f64) {
        let root_a = self.find(a);
        let root_b = self.find(b);
        if root_a == root_b {
            return;
        }
        let weight_a = self.weight[&root_a];
        let weight_b = self.weight[&root_b];
        self.parent.insert(root_a.clone(), root_b.clone());
        self.weight.insert(root_a, weight_b * value / weight_a);
    }

    fn query(&mut self, a: String, b: String) -> f64 {
        if !self.parent.contains_key(&a) || !self.parent.contains_key(&b) {
            return -1.0;
        }
        let root_a = self.find(a.clone());
        let root_b = self.find(b.clone());
        if root_a != root_b {
            return -1.0;
        }
        self.weight[&a] / self.weight[&b]
    }
}

impl Solution {
    pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut uf = UnionFind::new();
        for (i, equation) in equations.iter().enumerate() {
            let a = equation[0].clone();
            let b = equation[1].clone();
            uf.union(a, b, values[i]);
        }
        queries
            .into_iter()
            .map(|query| {
                let a = query[0].clone();
                let b = query[1].clone();
                uf.query(a, b)
            })
            .collect()
    }
}