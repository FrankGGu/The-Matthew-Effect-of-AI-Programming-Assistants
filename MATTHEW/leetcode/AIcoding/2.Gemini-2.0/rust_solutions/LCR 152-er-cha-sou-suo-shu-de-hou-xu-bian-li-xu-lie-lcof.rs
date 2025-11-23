impl Solution {
    pub fn verify_postorder(postorder: Vec<i32>) -> bool {
        fn recur(postorder: &[i32]) -> bool {
            if postorder.len() <= 1 {
                return true;
            }
            let root = postorder[postorder.len() - 1];
            let mut i = 0;
            while i < postorder.len() - 1 && postorder[i] < root {
                i += 1;
            }
            for j in i..postorder.len() - 1 {
                if postorder[j] < root {
                    return false;
                }
            }
            recur(&postorder[..i]) && recur(&postorder[i..postorder.len() - 1])
        }
        recur(&postorder)
    }
}