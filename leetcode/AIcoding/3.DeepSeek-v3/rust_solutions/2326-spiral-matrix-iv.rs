impl Solution {
    pub fn spiral_matrix(m: i32, n: i32, head: Option<Box<ListNode>>) -> Vec<Vec<i32>> {
        let m = m as usize;
        let n = n as usize;
        let mut matrix = vec![vec![-1; n]; m];
        let mut current = head;
        let (mut top, mut bottom, mut left, mut right) = (0, m - 1, 0, n - 1);

        while top <= bottom && left <= right {
            for i in left..=right {
                if let Some(node) = current {
                    matrix[top][i] = node.val;
                    current = node.next;
                } else {
                    break;
                }
            }
            top += 1;

            for i in top..=bottom {
                if let Some(node) = current {
                    matrix[i][right] = node.val;
                    current = node.next;
                } else {
                    break;
                }
            }
            if right == 0 {
                break;
            }
            right -= 1;

            if top <= bottom {
                for i in (left..=right).rev() {
                    if let Some(node) = current {
                        matrix[bottom][i] = node.val;
                        current = node.next;
                    } else {
                        break;
                    }
                }
                bottom -= 1;
            }

            if left <= right {
                for i in (top..=bottom).rev() {
                    if let Some(node) = current {
                        matrix[i][left] = node.val;
                        current = node.next;
                    } else {
                        break;
                    }
                }
                left += 1;
            }
        }
        matrix
    }
}