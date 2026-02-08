impl Solution {
    pub fn insert_greatest_common_divisors(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current = head;
        let mut result = current.clone();

        while let Some(mut node) = current {
            if node.next.is_none() {
                break;
            }

            let gcd_val = Solution::gcd(node.val, node.next.as_ref().unwrap().val);
            let new_node = Box::new(ListNode::new(gcd_val));

            let next_node = node.next.take();
            node.next = Some(new_node);
            node.next.as_mut().unwrap().next = next_node;

            current = node.next.as_mut().unwrap().next.clone();
        }

        result
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }
}