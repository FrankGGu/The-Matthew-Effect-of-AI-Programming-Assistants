#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    if head.is_none() || head.as_ref().unwrap().next.is_none() {
        return head;
    }

    let mut slow = head.as_ref().unwrap().clone();
    let mut fast = head.as_ref().unwrap().clone();
    let mut prev = None;

    while let Some(node) = fast {
        fast = node.next.clone();
        if let Some(next_node) = fast {
            fast = next_node.next.clone();
        } else {
            break;
        }
        prev = Some(slow.clone());
        slow = slow.next.clone().unwrap();
    }

    if let Some(p) = prev {
        p.next = None;
    }

    let left = sort_list(head);
    let right = sort_list(Some(slow));

    merge(left, right)
}

fn merge(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode { val: 0, next: None };
    let mut tail = &mut dummy;

    let mut l1 = l1;
    let mut l2 = l2;

    while l1.is_some() && l2.is_some() {
        if l1.as_ref().unwrap().val < l2.as_ref().unwrap().val {
            tail.next = l1;
            tail = tail.next.as_mut().unwrap();
            l1 = tail.next.take();
        } else {
            tail.next = l2;
            tail = tail.next.as_mut().unwrap();
            l2 = tail.next.take();
        }
    }

    tail.next = l1.or(l2);
    dummy.next
}