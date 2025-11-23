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
    pub fn double_it(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut num_str = String::new();
        let mut current = head;
        while let Some(node) = current {
            num_str.push_str(&node.val.to_string());
            current = node.next;
        }

        if num_str.is_empty() {
            return Some(Box::new(ListNode::new(0)));
        }

        let mut num: Vec<i32> = num_str.chars().map(|c| c.to_digit(10).unwrap() as i32).collect();

        let mut carry = 0;
        for i in (0..num.len()).rev() {
            let doubled = num[i] * 2 + carry;
            num[i] = doubled % 10;
            carry = doubled / 10;
        }

        if carry > 0 {
            num.insert(0, carry);
        }

        let mut head_node = None;
        let mut current_node = &mut head_node;

        for &digit in &num {
            let new_node = Some(Box::new(ListNode::new(digit)));
            *current_node = new_node;
            current_node = &mut current_node.as_mut().unwrap().next;
        }

        head_node
    }
}

struct Solution;