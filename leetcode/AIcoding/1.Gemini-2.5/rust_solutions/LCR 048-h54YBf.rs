use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

struct Codec {

}

impl Codec {

    fn new() -> Self {
        Codec {}
    }

    fn serialize(&self, root: Option<Rc<RefCell<TreeNode>>>) -> String {
        let mut result = String::new();
        self.serialize_helper(root, &mut result);
        if result.ends_with(',') {
            result.pop();
        }
        result
    }

    fn serialize_helper(&self, node: Option<Rc<RefCell<TreeNode>>>, result: &mut String) {
        match node {
            Some(n_rc) => {
                let n_ref = n_rc.borrow();
                result.push_str(&n_ref.val.to_string());
                result.push(',');
                self.serialize_helper(n_ref.left.clone(), result);
                self.serialize_helper(n_ref.right.clone(), result);
            },
            None => {
                result.push_str("#,");
            }
        }
    }

    fn deserialize(&self, data: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut nodes_str_iter: VecDeque<&str> = data.split(',').collect();
        self.deserialize_helper(&mut nodes_str_iter)
    }

    fn deserialize_helper(&self, nodes_str_iter: &mut VecDeque<&str>) -> Option<Rc<RefCell<TreeNode>>> {
        let val_str = nodes_str_iter.pop_front()?;

        if val_str == "#" {
            return None;
        }

        let val = val_str.parse::<i32>().unwrap();
        let node = Rc::new(RefCell::new(TreeNode::new(val)));

        node.borrow_mut().left = self.deserialize_helper(nodes_str_iter);
        node.borrow_mut().right = self.deserialize_helper(nodes_str_iter);

        Some(node)
    }
}