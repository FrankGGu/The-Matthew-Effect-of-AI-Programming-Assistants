#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: bool,
    pub is_leaf: bool,
    pub top_left: Option<Box<Node>>,
    pub top_right: Option<Box<Node>>,
    pub bottom_left: Option<Box<Node>>,
    pub bottom_right: Option<Box<Node>>,
}

impl Node {
    #[inline]
    pub fn new(val: bool, is_leaf: bool) -> Self {
        Node {
            val,
            is_leaf,
            top_left: None,
            top_right: None,
            bottom_left: None,
            bottom_right: None,
        }
    }
}

impl Solution {
    pub fn construct(grid: Vec<Vec<i32>>) -> Option<Box<Node>> {
        fn build_tree(grid: &Vec<Vec<i32>>, row_start: usize, col_start: usize, len: usize) -> Option<Box<Node>> {
            if len == 0 {
                return None;
            }

            let first_val = grid[row_start][col_start];
            let mut is_leaf = true;

            for i in row_start..row_start + len {
                for j in col_start..col_start + len {
                    if grid[i][j] != first_val {
                        is_leaf = false;
                        break;
                    }
                }
                if !is_leaf {
                    break;
                }
            }

            if is_leaf {
                return Some(Box::new(Node::new(first_val == 1, true)));
            } else {
                let half_len = len / 2;
                let top_left = build_tree(grid, row_start, col_start, half_len);
                let top_right = build_tree(grid, row_start, col_start + half_len, half_len);
                let bottom_left = build_tree(grid, row_start + half_len, col_start, half_len);
                let bottom_right = build_tree(grid, row_start + half_len, col_start + half_len, half_len);

                return Some(Box::new(Node {
                    val: false,
                    is_leaf: false,
                    top_left,
                    top_right,
                    bottom_left,
                    bottom_right,
                }));
            }
        }

        build_tree(&grid, 0, 0, grid.len())
    }
}

struct Solution;