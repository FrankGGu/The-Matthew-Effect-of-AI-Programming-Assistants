#[derive(Debug, PartialEq)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

#[derive(Debug, PartialEq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn sorted_list_to_bst(head: Option<Box<ListNode>>) -> Option<Box<TreeNode>> {
    fn convert_list_to_bst(start: usize, end: usize, nums: &[i32]) -> Option<Box<TreeNode>> {
        if start > end {
            return None;
        }
        let mid = (start + end) / 2;
        let mut node = TreeNode {
            val: nums[mid],
            left: convert_list_to_bst(start, mid - 1, nums),
            right: convert_list_to_bst(mid + 1, end, nums),
        };
        Some(Box::new(node))
    }

    let mut nums = vec![];
    let mut current = head;
    while let Some(node) = current {
        nums.push(node.val);
        current = node.next;
    }
    convert_list_to_bst(0, nums.len() - 1, &nums)
}