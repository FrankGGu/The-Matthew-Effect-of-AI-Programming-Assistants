class Solution:
    def balanceBST(self, root: TreeNode) -> TreeNode:
        nodes = []

        def inorder_traversal(node):
            if not node:
                return
            inorder_traversal(node.left)
            nodes.append(node)
            inorder_traversal(node.right)

        inorder_traversal(root)

        def build_balanced_bst(start, end):
            if start > end:
                return None

            mid = (start + end) // 2

            root_node = nodes[mid]
            root_node.left = build_balanced_bst(start, mid - 1)
            root_node.right = build_balanced_bst(mid + 1, end)

            return root_node

        return build_balanced_bst(0, len(nodes) - 1)