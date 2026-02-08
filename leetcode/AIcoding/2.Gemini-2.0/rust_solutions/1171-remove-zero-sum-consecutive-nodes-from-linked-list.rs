impl Solution {
    pub fn remove_zero_sum_sublists(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        use std::collections::HashMap;

        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut map: HashMap<i32, *mut ListNode> = HashMap::new();
        let mut sum = 0;
        let mut curr = &mut dummy;
        map.insert(0, &mut **curr as *mut ListNode);

        while let Some(node) = curr {
            sum += node.val;
            if let Some(&prev) = map.get(&sum) {
                let mut p = unsafe { &mut *prev };
                let mut s = sum;
                let mut next = unsafe { &mut *prev }.next.take();
                while let Some(n) = next {
                    s += n.val;
                    if s != sum {
                        map.remove(&s);
                    }
                    next = n.next;
                }
                p.next = node.next.take();
                map.insert(sum, &mut **curr as *mut ListNode);
            } else {
                map.insert(sum, &mut **curr as *mut ListNode);
            }
            curr = &mut node.next;
        }

        dummy.unwrap().next
    }
}