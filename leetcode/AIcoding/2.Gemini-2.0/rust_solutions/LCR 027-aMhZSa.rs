impl Solution {
    pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
        let mut v = Vec::new();
        let mut curr = head;
        while let Some(node) = curr {
            v.push(node.val);
            curr = node.next;
        }
        let n = v.len();
        for i in 0..n / 2 {
            if v[i] != v[n - i - 1] {
                return false;
            }
        }
        true
    }
}