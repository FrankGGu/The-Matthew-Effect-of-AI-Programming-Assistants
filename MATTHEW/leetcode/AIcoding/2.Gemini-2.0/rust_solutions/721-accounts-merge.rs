use std::collections::{HashMap, HashSet};

struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
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
            self.parent[root_x] = root_y;
        }
    }
}

impl Solution {
    pub fn accounts_merge(accounts: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut email_to_index: HashMap<String, usize> = HashMap::new();
        let mut email_to_name: HashMap<String, String> = HashMap::new();
        let mut index = 0;

        for account in &accounts {
            let name = account[0].clone();
            for i in 1..account.len() {
                let email = account[i].clone();
                if !email_to_index.contains_key(&email) {
                    email_to_index.insert(email.clone(), index);
                    email_to_name.insert(email.clone(), name.clone());
                    index += 1;
                }
            }
        }

        let mut dsu = DSU::new(index);

        for account in &accounts {
            let first_email = account[1].clone();
            let first_index = *email_to_index.get(&first_email).unwrap();
            for i in 2..account.len() {
                let email = account[i].clone();
                let email_index = *email_to_index.get(&email).unwrap();
                dsu.union(first_index, email_index);
            }
        }

        let mut index_to_emails: HashMap<usize, Vec<String>> = HashMap::new();
        for (email, &i) in &email_to_index {
            let root = dsu.find(i);
            index_to_emails.entry(root).or_insert(Vec::new()).push(email.clone());
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        for (_, emails) in index_to_emails {
            let mut sorted_emails = emails;
            sorted_emails.sort();
            let name = email_to_name.get(&sorted_emails[0]).unwrap().clone();
            let mut account: Vec<String> = Vec::new();
            account.push(name);
            account.extend(sorted_emails);
            result.push(account);
        }

        result
    }
}