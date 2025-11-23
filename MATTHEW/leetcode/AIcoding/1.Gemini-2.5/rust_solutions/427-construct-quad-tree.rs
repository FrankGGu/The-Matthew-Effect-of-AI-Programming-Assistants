struct Solution;

impl Solution {
    pub fn construct(grid: Vec<Vec<i32>>) -> Option<Box<Node>> {
        let n = grid.len();
        Self::build_quad_tree(&grid, 0, 0, n)
    }

    fn build_quad_tree(grid: &Vec<Vec<i32>>, r_start: usize, c_start: usize, size: usize) -> Option<Box<Node>> {
        let first_val = grid[r_start][c_start];
        let mut is_uniform = true;

        'outer: for r in r_start..(r_start + size) {
            for c in c_start..(c_start + size) {
                if grid[r][c] != first_val {
                    is_uniform = false;
                    break 'outer;
                }
            }
        }

        if is_uniform {
            Some(Box::new(Node::new(first_val == 1, true)))
        } else {
            let half_size = size / 2;
            let mut node = Node::new(true, false); 
            node.top_left = Self::build_quad_tree(grid, r_start, c_start, half_size);
            node.top_right = Self::build_quad_tree(grid, r_start, c_start + half_size, half_size);
            node.bottom_left = Self::build_quad_tree(grid, r_start + half_size, c_start, half_size);
            node.bottom_right = Self::build_quad_tree(grid, r_start + half_size, c_start + half_size, half_size);
            Some(Box::new(node))
        }
    }
}