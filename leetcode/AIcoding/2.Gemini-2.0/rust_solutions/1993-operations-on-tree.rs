struct LockingTree {
    parent: Vec<i32>,
    children: Vec<Vec<i32>>,
    locked: Vec<i32>,
}

impl LockingTree {
    fn new(parent: Vec<i32>) -> Self {
        let n = parent.len();
        let mut children = vec![Vec::new(); n];
        for i in 0..n {
            if parent[i] != -1 {
                children[parent[i] as usize].push(i as i32);
            }
        }
        LockingTree {
            parent,
            children,
            locked: vec![0; n],
        }
    }

    fn lock(&mut self, num: i32, user: i32) -> bool {
        if self.locked[num as usize] == 0 {
            self.locked[num as usize] = user;
            return true;
        }
        false
    }

    fn unlock(&mut self, num: i32, user: i32) -> bool {
        if self.locked[num as usize] == user {
            self.locked[num as usize] = 0;
            return true;
        }
        false
    }

    fn upgrade(&mut self, num: i32, user: i32) -> bool {
        if self.locked[num as usize] != 0 {
            return false;
        }

        let mut ancestor = self.parent[num as usize];
        while ancestor != -1 {
            if self.locked[ancestor as usize] != 0 {
                return false;
            }
            ancestor = self.parent[ancestor as usize];
        }

        let mut count = 0;
        let mut stack = vec![num];
        let mut unlock_nodes = vec![];

        while let Some(node) = stack.pop() {
            if self.locked[node as usize] != 0 {
                count += 1;
                unlock_nodes.push(node);
            }
            for &child in &self.children[node as usize] {
                stack.push(child);
            }
        }

        if count == 0 {
            return false;
        }

        for node in unlock_nodes {
            self.locked[node as usize] = 0;
        }

        self.locked[num as usize] = user;
        true
    }
}