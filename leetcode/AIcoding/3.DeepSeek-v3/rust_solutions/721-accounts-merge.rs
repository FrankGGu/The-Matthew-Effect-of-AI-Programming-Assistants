use std::collections::{HashMap, HashSet};

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            self.parent[root_y] = root_x;
        }
    }
}

impl Solution {
    pub fn accounts_merge(accounts: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let n = accounts.len();
        let mut uf = UnionFind::new(n);
        let mut email_to_id = HashMap::new();

        for (i, account) in accounts.iter().enumerate() {
            for email in account.iter().skip(1) {
                if let Some(&id) = email_to_id.get(email) {
                    uf.union(id, i);
                } else {
                    email_to_id.insert(email.clone(), i);
                }
            }
        }

        let mut id_to_emails = HashMap::new();
        for (email, &id) in email_to_id.iter() {
            let root = uf.find(id);
            id_to_emails.entry(root).or_insert_with(HashSet::new).insert(email.clone());
        }

        let mut result = Vec::new();
        for (id, emails) in id_to_emails {
            let mut emails: Vec<String> = emails.into_iter().collect();
            emails.sort();
            let mut merged = vec![accounts[id][0].clone()];
            merged.extend(emails);
            result.push(merged);
        }

        result
    }
}