use std::collections::HashMap;

struct Dsu {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl Dsu {
    fn new(n: usize) -> Self {
        Dsu {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
            }
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn accounts_merge(accounts: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut email_to_id: HashMap<String, usize> = HashMap::new();
        let mut id_counter: usize = 0;

        for account in &accounts {
            for i in 1..account.len() {
                let email = &account[i];
                if !email_to_id.contains_key(email) {
                    email_to_id.insert(email.clone(), id_counter);
                    id_counter += 1;
                }
            }
        }

        let mut dsu = Dsu::new(id_counter);

        for account in &accounts {
            let first_email_id = *email_to_id.get(&account[1]).unwrap();

            for i in 2..account.len() {
                let current_email_id = *email_to_id.get(&account[i]).unwrap();
                dsu.union(first_email_id, current_email_id);
            }
        }

        let mut merged_accounts_map: HashMap<usize, (String, Vec<String>)> = HashMap::new();

        for account in &accounts {
            let name = &account[0];
            let first_email_id = *email_to_id.get(&account[1]).unwrap();
            let root_id = dsu.find(first_email_id);
            merged_accounts_map.entry(root_id).or_insert((name.clone(), Vec::new()));
        }

        for (email_str, &email_id) in email_to_id.iter() {
            let root_id = dsu.find(email_id);
            let entry = merged_accounts_map.get_mut(&root_id).unwrap();
            entry.1.push(email_str.clone());
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        for (_, (name, mut emails)) in merged_accounts_map {
            emails.sort();
            let mut account_entry = Vec::with_capacity(1 + emails.len());
            account_entry.push(name);
            account_entry.extend(emails);
            result.push(account_entry);
        }

        result
    }
}