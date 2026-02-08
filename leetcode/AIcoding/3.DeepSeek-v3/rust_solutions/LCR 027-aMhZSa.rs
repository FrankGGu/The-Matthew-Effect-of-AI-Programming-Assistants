impl Solution {
    pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
        let mut vals = Vec::new();
        let mut current = head.as_ref();
        while let Some(node) = current {
            vals.push(node.val);
            current = node.next.as_ref();
        }

        let mut left = 0;
        let mut right = vals.len() - 1;
        while left < right {
            if vals[left] != vals[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}