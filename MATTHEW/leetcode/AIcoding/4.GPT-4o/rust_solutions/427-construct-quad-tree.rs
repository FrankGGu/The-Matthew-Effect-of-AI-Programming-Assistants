#[derive(Debug, PartialEq)]
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
    fn new(val: bool, is_leaf: bool) -> Self {
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

pub fn construct(grid: Vec<Vec<i32>>) -> Option<Box<Node>> {
    fn build(grid: &Vec<Vec<i32>>, x: usize, y: usize, length: usize) -> Option<Box<Node>> {
        if length == 1 {
            return Some(Box::new(Node::new(grid[x][y] == 1, true)));
        }

        let half = length / 2;
        let top_left = build(grid, x, y, half);
        let top_right = build(grid, x, y + half, half);
        let bottom_left = build(grid, x + half, y, half);
        let bottom_right = build(grid, x + half, y + half, half);

        if let (Some(tl), Some(tr), Some(bl), Some(br)) = (&top_left, &top_right, &bottom_left, &bottom_right) {
            if tl.is_leaf && tr.is_leaf && bl.is_leaf && br.is_leaf && tl.val == tr.val && tl.val == bl.val && tl.val == br.val {
                return Some(Box::new(Node::new(tl.val, true)));
            }
        }

        let mut node = Node::new(false, false);
        node.top_left = top_left;
        node.top_right = top_right;
        node.bottom_left = bottom_left;
        node.bottom_right = bottom_right;
        Some(Box::new(node))
    }

    if grid.is_empty() {
        None
    } else {
        build(&grid, 0, 0, grid.len())
    }
}