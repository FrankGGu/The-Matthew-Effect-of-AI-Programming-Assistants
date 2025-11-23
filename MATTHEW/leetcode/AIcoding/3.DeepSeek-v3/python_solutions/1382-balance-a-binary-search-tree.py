class Solution:
    def balanceBST(self, root: TreeNode) -> TreeNode:
        nodes = []

        def inorder(node):
            if not node:
                return
            inorder(node.left)
            nodes.append(node)
            inorder(node.right)

        inorder(root)

        def build(l, r):
            if l > r:
                return None
            mid = (l + r) // 2
            root = nodes[mid]
            root.left = build(l, mid - 1)
            root.right = build(mid + 1, r)
            return root

        return build(0, len(nodes) - 1)