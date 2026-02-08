use rand::Rng;

struct Solution {
    head: Option<Box<ListNode>>,
}

impl Solution {
    fn new(head: Option<Box<ListNode>>) -> Self {
        Solution { head }
    }

    fn get_random(&self) -> i32 {
        let mut result = 0;
        let mut count = 0;
        let mut current = &self.head;
        let mut rng = rand::thread_rng();

        while let Some(node) = current {
            count += 1;
            if rng.gen_range(0..count) == 0 {
                result = node.val;
            }
            current = &node.next;
        }
        result
    }
}