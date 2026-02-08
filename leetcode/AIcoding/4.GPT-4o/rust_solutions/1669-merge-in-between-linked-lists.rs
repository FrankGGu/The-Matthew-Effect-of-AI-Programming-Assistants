#[derive(ListEnum)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn merge_in_between(list1: Option<Box<ListNode>>, a: i32, b: i32, list2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode { val: 0, next: None };
    let mut prev = &mut dummy;
    let mut current = list1;

    while let Some(mut node) = current {
        if node.val == a {
            break;
        }
        prev.next = Some(node);
        current = prev.next.as_mut().unwrap().next.take();
        prev = prev.next.as_mut().unwrap();
    }

    current = current.and_then(|mut node| node.next.take());
    while let Some(mut node) = current {
        if node.val == b {
            break;
        }
        current = node.next.take();
    }

    let mut tail = list2;
    while let Some(mut node) = tail {
        prev.next = Some(node);
        prev = prev.next.as_mut().unwrap();
        tail = prev.next.take();
    }

    prev.next = current;

    dummy.next
}