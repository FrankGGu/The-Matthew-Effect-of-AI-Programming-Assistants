class Solution:
    def balanceBST(self, root: TreeNode) -> TreeNode:
        def inorder_traversal(node):
            if not node:
                return []
            return inorder_traversal(node.left) + [node.val] + inorder_traversal(node.right)

        def build_balanced_bst(nums, left, right):
            if left > right:
                return None
            mid = (left + right) // 2
            node = TreeNode(nums[mid])
            node.left = build_balanced_bst(nums, left, mid - 1)
            node.right = build_balanced_bst(nums, mid + 1, right)
            return node

        sorted_vals = inorder_traversal(root)
        return build_balanced_bst(sorted_vals, 0, len(sorted_vals) - 1)