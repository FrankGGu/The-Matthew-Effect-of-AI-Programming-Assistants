class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sortedListToBST(self, head: ListNode) -> TreeNode:

        count = 0
        current = head
        while current:
            count += 1
            current = current.next

        self.head_ptr = head

        def build_bst_inorder(n):
            if n <= 0:
                return None

            left_child = build_bst_inorder(n // 2)

            root = TreeNode(self.head_ptr.val)
            root.left = left_child

            self.head_ptr = self.head_ptr.next

            right_child = build_bst_inorder(n - 1 - n // 2)
            root.right = right_child

            return root

        return build_bst_inorder(count)