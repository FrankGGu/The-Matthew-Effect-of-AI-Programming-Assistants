use rand::prelude::*;

struct Solution {
    head: Option<Box<ListNode>>,
    rng: ThreadRng,
}

impl Solution {
    fn new(head: Option<Box<ListNode>>) -> Self {
        Solution {
            head,
            rng: thread_rng(),
        }
    }

    fn get_random(&mut self) -> i32 {
        let mut scope = 1;
        let mut result = 0;
        let mut current = self.head.as_ref();

        while let Some(node) = current {
            if self.rng.gen_range(0, scope) == 0 {
                result = node.val;
            }
            scope += 1;
            current = node.next.as_ref();
        }

        result
    }
}