impl Solution {
    pub fn get_decimal_value(head: Option<Box<ListNode>>) -> i32 {
        let mut num = 0;
        let mut current = head;

        while let Some(node) = current {
            num = (num << 1) | node.val;
            current = node.next;
        }

        num
    }
}