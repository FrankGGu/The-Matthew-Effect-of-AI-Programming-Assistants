use std::collections::HashMap;
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, Default)]
struct TrieNode {
    children: HashMap<String, Rc<RefCell<TrieNode>>>,
    deleted: bool,
}

impl Solution {
    pub fn delete_duplicate_folder(paths: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let root = Rc::new(RefCell::new(TrieNode::default()));

        for path in paths {
            let mut node = Rc::clone(&root);
            for folder in path {
                let mut node_mut = node.borrow_mut();
                let next = node_mut.children.entry(folder.clone())
                    .or_insert_with(|| Rc::new(RefCell::new(TrieNode::default())))
                    .clone();
                drop(node_mut);
                node = next;
            }
        }

        let mut seen = HashMap::new();
        Self::dedup(Rc::clone(&root), &mut seen);

        let mut ans = Vec::new();
        let mut path = Vec::new();
        Self::get_paths(Rc::clone(&root), &mut path, &mut ans);
        ans
    }

    fn dedup(node: Rc<RefCell<TrieNode>>, seen: &mut HashMap<String, Rc<RefCell<TrieNode>>>) -> String {
        let mut key = String::new();
        let mut node_borrow = node.borrow();
        let mut child_keys: Vec<(String, String)> = node_borrow.children
            .iter()
            .map(|(name, child)| {
                let child_key = Self::dedup(Rc::clone(child), seen);
                (name.clone(), child_key)
            })
            .collect();
        drop(node_borrow);

        child_keys.sort();
        for (name, child_key) in child_keys {
            key.push_str(&format!("{}({})", name, child_key));
        }

        if !key.is_empty() {
            if let Some(seen_node) = seen.get(&key) {
                seen_node.borrow_mut().deleted = true;
                node.borrow_mut().deleted = true;
            } else {
                seen.insert(key.clone(), Rc::clone(&node));
            }
        }

        key
    }

    fn get_paths(node: Rc<RefCell<TrieNode>>, path: &mut Vec<String>, ans: &mut Vec<Vec<String>>) {
        let node_borrow = node.borrow();
        if node_borrow.deleted {
            return;
        }

        if !path.is_empty() {
            ans.push(path.clone());
        }

        for (name, child) in &node_borrow.children {
            path.push(name.clone());
            Self::get_paths(Rc::clone(child), path, ans);
            path.pop();
        }
    }
}