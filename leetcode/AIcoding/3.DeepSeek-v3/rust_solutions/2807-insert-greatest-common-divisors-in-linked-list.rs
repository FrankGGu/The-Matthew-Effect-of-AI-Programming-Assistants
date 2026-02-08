impl Solution {
    pub fn insert_greatest_common_divisors(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current = head.as_mut();
        while let Some(node) = current {
            if let Some(next_node) = node.next.as_mut() {
                let gcd_val = gcd(node.val, next_node.val);
                let mut new_node = Box::new(ListNode::new(gcd_val));
                new_node.next = node.next.take();
                node.next = Some(new_node);
                current = node.next.as_mut().and_then(|n| n.next.as_mut());
            } else {
                break;
            }
        }
        head
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}