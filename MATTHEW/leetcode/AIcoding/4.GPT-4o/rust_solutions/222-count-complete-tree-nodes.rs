#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn count_nodes(root: Option<Box<TreeNode>>) -> i32 {
    let mut depth = 0;
    let mut node = &root;

    while let Some(n) = node {
        depth += 1;
        node = &n.left;
    }

    let mut left = 0;
    let mut right = 2_usize.pow(depth) - 1;
    let mut count = 0;

    while left <= right {
        let mid = (left + right) / 2;
        if exists(mid, depth, &root) {
            count = mid + 1;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    count
}

fn exists(index: usize, depth: i32, root: &Option<Box<TreeNode>>) -> bool {
    let mut node = root;
    let mut left = 0;
    let mut right = 2_usize.pow(depth as u32) - 1;

    for _ in 0..depth {
        let mid = (left + right) / 2;
        if index <= mid {
            node = &node.as_ref()?.left;
            right = mid;
        } else {
            node = &node.as_ref()?.right;
            left = mid + 1;
        }
    }

    node.is_some()
}