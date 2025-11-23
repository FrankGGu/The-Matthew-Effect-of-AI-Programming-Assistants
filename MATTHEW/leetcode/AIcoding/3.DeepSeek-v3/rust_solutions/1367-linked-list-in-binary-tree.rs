use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn is_sub_path(head: Option<Box<ListNode>>, root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if head.is_none() {
            return true;
        }
        if root.is_none() {
            return false;
        }
        let root_node = root.unwrap();
        let root_ref = root_node.borrow();
        Self::dfs(&head, &root_node) || 
        Self::is_sub_path(head.clone(), root_ref.left.clone()) || 
        Self::is_sub_path(head.clone(), root_ref.right.clone())
    }

    fn dfs(list: &Option<Box<ListNode>>, tree: &Rc<RefCell<TreeNode>>) -> bool {
        if list.is_none() {
            return true;
        }
        if tree.borrow().val != list.as_ref().unwrap().val {
            return false;
        }
        let next_list = &list.as_ref().unwrap().next;
        let tree_node = tree.borrow();
        (next_list.is_none() && tree_node.left.is_none() && tree_node.right.is_none()) || 
        (!next_list.is_none() && !tree_node.left.is_none() && Self::dfs(next_list, &tree_node.left.as_ref().unwrap())) || 
        (!next_list.is_none() && !tree_node.right.is_none() && Self::dfs(next_list, &tree_node.right.as_ref().unwrap())) || 
        (next_list.is_none() && (!tree_node.left.is_none() || !tree_node.right.is_none()))
    }
}