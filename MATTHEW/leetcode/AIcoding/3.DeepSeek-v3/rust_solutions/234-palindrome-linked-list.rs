impl Solution {
    pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
        let mut vec = Vec::new();
        let mut current = &head;
        while let Some(node) = current {
            vec.push(node.val);
            current = &node.next;
        }
        let mut left = 0;
        let mut right = vec.len() - 1;
        while left < right {
            if vec[left] != vec[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}