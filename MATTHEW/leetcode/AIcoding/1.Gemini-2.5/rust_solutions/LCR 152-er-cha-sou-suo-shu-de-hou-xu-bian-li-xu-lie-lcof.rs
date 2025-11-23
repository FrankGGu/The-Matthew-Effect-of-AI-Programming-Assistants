impl Solution {
    pub fn verify_postorder(postorder: Vec<i32>) -> bool {
        if postorder.is_empty() {
            return true;
        }
        Self::is_valid_post_order_recursive(&postorder, 0, postorder.len() as i32 - 1)
    }

    fn is_valid_post_order_recursive(sequence: &[i32], start: i32, end: i32) -> bool {
        if start >= end {
            return true;
        }

        let root_val = sequence[end as usize];

        let mut i = start;
        while i < end && sequence[i as usize] < root_val {
            i += 1;
        }

        let mut j = i;
        while j < end {
            if sequence[j as usize] <= root_val {
                return false;
            }
            j += 1;
        }

        Self::is_valid_post_order_recursive(sequence, start, i - 1) &&
        Self::is_valid_post_order_recursive(sequence, i, end - 1)
    }
}