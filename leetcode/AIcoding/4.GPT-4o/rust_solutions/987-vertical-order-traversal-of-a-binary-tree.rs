use std::collections::{VecDeque, HashMap};

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn vertical_order(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
    let mut columns: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut min_col = 0;
    let mut max_col = 0;

    fn traverse(node: Option<&Box<TreeNode>>, col: i32, row: i32, columns: &mut HashMap<i32, Vec<(i32, i32)>>) {
        if let Some(n) = node {
            columns.entry(col).or_default().push((row, n.val));
            traverse(n.left.as_deref(), col - 1, row + 1, columns);
            traverse(n.right.as_deref(), col + 1, row + 1, columns);
        }
    }

    traverse(root.as_deref(), 0, 0, &mut columns);

    for &col in columns.keys() {
        if col < min_col {
            min_col = col;
        }
        if col > max_col {
            max_col = col;
        }
    }

    let mut result = Vec::new();
    for col in min_col..=max_col {
        if let Some(mut values) = columns.remove(&col) {
            values.sort();
            result.push(values.into_iter().map(|(_, val)| val).collect());
        }
    }

    result
}