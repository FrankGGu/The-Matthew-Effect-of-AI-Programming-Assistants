impl Solution {
    pub fn spiral_matrix(m: i32, n: i32, head: Option<Box<ListNode>>) -> Vec<Vec<i32>> {
        let m = m as usize;
        let n = n as usize;
        let mut matrix = vec![vec![-1; n]; m];
        let mut row_start = 0;
        let mut row_end = m - 1;
        let mut col_start = 0;
        let mut col_end = n - 1;
        let mut current = head;

        while row_start <= row_end && col_start <= col_end {
            for i in col_start..=col_end {
                if let Some(node) = current {
                    matrix[row_start][i] = node.val;
                    current = node.next;
                } else {
                    return matrix;
                }
            }
            row_start += 1;

            for i in row_start..=row_end {
                if let Some(node) = current {
                    matrix[i][col_end] = node.val;
                    current = node.next;
                } else {
                    return matrix;
                }
            }
            if col_start <= col_end {
                col_end -= 1;
            }

            if row_start <= row_end {
                for i in (col_start..=col_end).rev() {
                    if let Some(node) = current {
                        matrix[row_end][i] = node.val;
                        current = node.next;
                    } else {
                        return matrix;
                    }
                }
                row_end -= 1;
            }

            if col_start <= col_end {
                for i in (row_start..=row_end).rev() {
                    if let Some(node) = current {
                        matrix[i][col_start] = node.val;
                        current = node.next;
                    } else {
                        return matrix;
                    }
                }
                col_start += 1;
            }
        }
        matrix
    }
}