use std::collections::HashMap;

struct LockingTree {
    parent: Vec<i32>,
    children: Vec<Vec<i32>>,
    locked: HashMap<i32, i32>,
}

impl LockingTree {
    fn new(parent: Vec<i32>) -> Self {
        let n = parent.len();
        let mut children = vec![vec![]; n];
        for i in 1..n {
            let p = parent[i] as usize;
            children[p].push(i as i32);
        }
        LockingTree {
            parent,
            children,
            locked: HashMap::new(),
        }
    }

    fn lock(&mut self, num: i32, user: i32) -> bool {
        if self.locked.contains_key(&num) {
            false
        } else {
            self.locked.insert(num, user);
            true
        }
    }

    fn unlock(&mut self, num: i32, user: i32) -> bool {
        if let Some(&u) = self.locked.get(&num) {
            if u == user {
                self.locked.remove(&num);
                true
            } else {
                false
            }
        } else {
            false
        }
    }

    fn upgrade(&mut self, num: i32, user: i32) -> bool {
        if self.locked.contains_key(&num) {
            return false;
        }

        if !self.has_locked_descendant(num) {
            return false;
        }

        if self.has_locked_ancestor(num) {
            return false;
        }

        self.unlock_descendants(num);
        self.locked.insert(num, user);
        true
    }

    fn has_locked_descendant(&self, num: i32) -> bool {
        for &child in &self.children[num as usize] {
            if self.locked.contains_key(&child) || self.has_locked_descendant(child) {
                return true;
            }
        }
        false
    }

    fn has_locked_ancestor(&self, num: i32) -> bool {
        let mut current = num;
        while current != -1 {
            let p = self.parent[current as usize];
            if self.locked.contains_key(&p) {
                return true;
            }
            current = p;
        }
        false
    }

    fn unlock_descendants(&mut self, num: i32) {
        for &child in &self.children[num as usize] {
            self.locked.remove(&child);
            self.unlock_descendants(child);
        }
    }
}