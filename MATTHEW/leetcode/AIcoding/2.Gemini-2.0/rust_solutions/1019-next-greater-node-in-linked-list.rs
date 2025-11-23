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
    pub fn next_larger_nodes(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut nums = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            nums.push(node.val);
            current = node.next;
        }

        let n = nums.len();
        let mut result = vec![0; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && nums[i] > nums[*stack.last().unwrap()] {
                let index = stack.pop().unwrap();
                result[index] = nums[i];
            }
            stack.push(i);
        }

        result
    }
}