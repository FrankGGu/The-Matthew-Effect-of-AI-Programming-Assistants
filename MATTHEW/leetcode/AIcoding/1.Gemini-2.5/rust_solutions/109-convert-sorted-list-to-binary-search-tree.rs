use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sorted_list_to_bst(head: Option<Box<ListNode>>) -> Option<Rc<RefCell<TreeNode>>> {
        if head.is_none() {
            return None;
        }

        let mut len = 0;
        let mut current = head.as_ref();
        while let Some(node) = current {
            len += 1;
            current = node.next.as_ref();
        }

        let current_list_node_ref = RefCell::new(head);

        Self::build_bst_in_place(&current_list_node_ref, 0, len - 1)
    }

    fn build_bst_in_place(
        current_list_node_ref: &RefCell<Option<Box<ListNode>>>,
        start: i32,
        end: i32,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if start > end {
            return None;
        }

        let mid = start + (end - start) / 2;

        let left_child = Self::build_bst_in_place(current_list_node_ref, start, mid - 1);

        let mut list_node_opt = current_list_node_ref.borrow_mut().take();
        let mut list_node = list_node_opt.unwrap();

        let val = list_node.val;
        let next_list_node = list_node.next.take();

        *current_list_node_ref.borrow_mut() = next_list_node;

        let mut root_node = TreeNode::new(val);
        root_node.left = left_child;

        root_node.right = Self::build_bst_in_place(current_list_node_ref, mid + 1, end);

        Some(Rc::new(RefCell::new(root_node)))
    }
}