pub fn verify_postorder(postorder: Vec<i32>) -> bool {
    fn helper(postorder: &[i32], start: usize, end: usize) -> bool {
        if start >= end {
            return true;
        }
        let root = postorder[end];
        let mut mid = start;
        while mid < end && postorder[mid] < root {
            mid += 1;
        }
        let right_start = mid;
        while mid < end && postorder[mid] > root {
            mid += 1;
        }
        mid == end && helper(postorder, start, right_start - 1) && helper(postorder, right_start, end - 1)
    }
    helper(&postorder, 0, postorder.len() - 1)
}