impl Solution {
    pub fn spiral_matrix(m: i32, n: i32, head: Option<Box<ListNode>>) -> Vec<Vec<i32>> {
        let m_usize = m as usize;
        let n_usize = n as usize;
        let mut matrix = vec![vec![-1; n_usize]; m_usize];

        let mut current_node_ptr = &mut head;

        let mut top = 0;
        let mut bottom = m - 1;
        let mut left = 0;
        let mut right = n - 1;

        while top <= bottom && left <= right {
            // Traverse Right
            for c in left..=right {
                if let Some(node) = current_node_ptr {
                    matrix[top as usize][c as usize] = node.val;
                    current_node_ptr = &mut node.next;
                } else {
                    return matrix;
                }
            }
            top += 1;

            // Traverse Down
            if top <= bottom {
                for r in top..=bottom {
                    if let Some(node) = current_node_ptr {
                        matrix[r as usize][right as usize] = node.val;
                        current_node_ptr = &mut node.next;
                    } else {
                        return matrix;
                    }
                }
                right -= 1;
            }

            // Traverse Left
            if left <= right && top <= bottom {
                for c in (left..=right).rev() {
                    if let Some(node) = current_node_ptr {
                        matrix[bottom as usize][c as usize] = node.val;
                        current_node_ptr = &mut node.next;
                    } else {
                        return matrix;
                    }
                }
                bottom -= 1;
            }

            // Traverse Up
            if top <= bottom && left <= right {
                for r in (top..=bottom).rev() {
                    if let Some(node) = current_node_ptr {
                        matrix[r as usize][left as usize] = node.val;
                        current_node_ptr = &mut node.next;
                    } else {
                        return matrix;
                    }
                }
                left += 1;
            }
        }

        matrix
    }
}