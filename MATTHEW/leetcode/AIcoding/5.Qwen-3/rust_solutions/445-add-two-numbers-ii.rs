impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<ListNode>>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn add_two_numbers(
    l1: Option<Rc<RefCell<ListNode>>>,
    l2: Option<Rc<RefCell<ListNode>>>,
) -> Option<Rc<RefCell<ListNode>>> {
    let mut num1 = String::new();
    let mut num2 = String::new();

    let mut current = l1;
    while let Some(node) = current {
        num1.push((node.borrow().val as u8 + b'0') as char);
        current = node.borrow().next.clone();
    }

    current = l2;
    while let Some(node) = current {
        num2.push((node.borrow().val as u8 + b'0') as char);
        current = node.borrow().next.clone();
    }

    let mut result = Vec::new();
    let mut carry = 0;
    let mut i = num1.len() as i32 - 1;
    let mut j = num2.len() as i32 - 1;

    while i >= 0 || j >= 0 || carry > 0 {
        let digit1 = if i >= 0 { num1.as_bytes()[i as usize] - b'0' } else { 0 };
        let digit2 = if j >= 0 { num2.as_bytes()[j as usize] - b'0' } else { 0 };

        let sum = digit1 as i32 + digit2 as i32 + carry;
        carry = sum / 10;
        result.push(sum % 10);

        i -= 1;
        j -= 1;
    }

    let mut head = None;
    for &digit in result.iter().rev() {
        let node = Rc::new(RefCell::new(ListNode::new(digit as i32)));
        node.borrow_mut().next = head;
        head = Some(node);
    }

    head
}
}