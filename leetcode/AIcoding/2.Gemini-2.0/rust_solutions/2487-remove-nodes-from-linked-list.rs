impl Solution {
    pub fn remove_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut stack: Vec<i32> = vec![];
        let mut nums: Vec<i32> = vec![];
        let mut current = head;

        while let Some(node) = current {
            nums.push(node.val);
            current = node.next;
        }

        for &num in &nums {
            while !stack.is_empty() && *stack.last().unwrap() < num {
                stack.pop();
            }
            stack.push(num);
        }

        let mut head = None;
        for &val in &stack.into_iter().rev().collect::<Vec<_>>() {
            head = Some(Box::new(ListNode { val, next: head }));
        }

        head
    }
}