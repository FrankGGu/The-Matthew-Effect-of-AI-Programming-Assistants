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
        fn build(grid: &[Vec<i32>], x: usize, y: usize, size: usize) -> Option<Box<Node>> {
            if size == 1 {
                return Some(Box::new(Node::new(grid[x][y] == 1, true)));
            }
            let half = size / 2;
            let top_left = build(grid, x, y, half)?;
            let top_right = build(grid, x, y + half, half)?;
            let bottom_left = build(grid, x + half, y, half)?;
            let bottom_right = build(grid, x + half, y + half, half)?;

            if top_left.is_leaf && top_right.is_leaf && bottom_left.is_leaf && bottom_right.is_leaf &&
               top_left.val == top_right.val && top_right.val == bottom_left.val && bottom_left.val == bottom_right.val {
                Some(Box::new(Node::new(top_left.val, true)))
            } else {
                Some(Box::new(Node {
                    val: false,
                    is_leaf: false,
                    top_left,
                    top_right,
                    bottom_left,
                    bottom_right,
                }))
            }
        }
        build(&grid, 0, 0, grid.len())
    }
}