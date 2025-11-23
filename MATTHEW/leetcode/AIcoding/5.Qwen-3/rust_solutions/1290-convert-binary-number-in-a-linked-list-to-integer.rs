impl Solution {
    pub fn get_decimal_value(head: Option<Box<ListNode>>) -> i32 {
        let mut result = 0;
        let mut current = head;
        while let Some(node) = current {
            result = result * 2 + node.val;
            current = node.next;
        }
        result
    }
}