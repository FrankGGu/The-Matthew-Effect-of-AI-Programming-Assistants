struct LockingTree {
    parent: Vec<i32>,
    locked_by: Vec<Option<i32>>, // None if unlocked, Some(user_id) if locked
    children: Vec<Vec<i32>>, // Adjacency list for children
}

impl LockingTree {
    fn new(parent: Vec<i32>) -> Self {
        let n = parent.len();
        let mut children = vec![vec![]; n];
        for i in 1..n {
            children[parent[i] as usize].push(i as i32);
        }

        LockingTree {
            parent,
            locked_by: vec![None; n],
            children,
        }
    }

    fn lock(&mut self, num: i32, user: i32) -> bool {
        if self.locked_by[num as usize].is_none() {
            self.locked_by[num as usize] = Some(user);
            true
        } else {
            false
        }
    }

    fn unlock(&mut self, num: i32, user: i32) -> bool {
        if let Some(locked_user) = self.locked_by[num as usize] {
            if locked_user == user {
                self.locked_by[num as usize] = None;
                true
            } else {
                false
            }
        } else {
            false
        }
    }

    fn upgrade(&mut self, num: i32, user: i32) -> bool {
        // Condition 1: Node num must be unlocked.
        if self.locked_by[num as usize].is_some() {
            return false;
        }

        // Condition 3: No ancestor of node num can be locked.
        if self.has_locked_ancestor(num) {
            return false;
        }

        // Condition 2: At least one descendant of node num must be locked.
        // Also, unlock all locked descendants if upgrade is successful.
        let mut has_locked_desc = false;
        self.check_and_unlock_descendants(num, &mut has_locked_desc);

        if !has_locked_desc {
            return false;
        }

        // All conditions met, perform upgrade
        self.locked_by[num as usize] = Some(user);
        true
    }

    // Helper to check if any ancestor is locked
    fn has_locked_ancestor(&self, mut node_idx: i32) -> bool {
        while node_idx != -1 {
            if self.locked_by[node_idx as usize].is_some() {
                return true;
            }
            node_idx = self.parent[node_idx as usize];
        }
        false
    }

    // Helper to check for locked descendants and unlock them.
    // This function modifies `self.locked_by` and updates `has_locked_desc`.
    fn check_and_unlock_descendants(&mut self, node_idx: i32, has_locked_desc: &mut bool) {
        // DFS traversal
        for &child in &self.children[node_idx as usize] {
            if self.locked_by[child as usize].is_some() {
                *has_locked_desc = true;
                self.locked_by[child as usize] = None; // Unlock it
            }
            self.check_and_unlock_descendants(child, has_locked_desc);
        }
    }
}