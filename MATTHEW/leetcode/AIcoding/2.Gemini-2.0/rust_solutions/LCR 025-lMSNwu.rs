#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

impl Solution {
    pub fn add_two_numbers(
        l1: Option<Box<ListNode>>,
        l2: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut stack1 = Vec::new();
        let mut stack2 = Vec::new();

        let mut current = l1;
        while let Some(node) = current {
            stack1.push(node.val);
            current = node.next;
        }

        let mut current = l2;
        while let Some(node) = current {
            stack2.push(node.val);
            current = node.next;
        }

        let mut carry = 0;
        let mut result = None;

        while !stack1.is_empty() || !stack2.is_empty() || carry != 0 {
            let mut sum = carry;
            if let Some(val) = stack1.pop() {
                sum += val;
            }
            if let Some(val) = stack2.pop() {
                sum += val;
            }

            carry = sum / 10;
            let digit = sum % 10;

            let new_node = Some(Box::new(ListNode {
                val: digit,
                next: result,
            }));
            result = new_node;
        }

        result
    }
}

struct Solution;