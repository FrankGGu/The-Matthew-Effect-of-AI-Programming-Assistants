class Solution:
    def countNodes(self, root: TreeNode) -> int:
        if not root:
            return 0

        def get_left_depth(node):
            depth = 0
            while node:
                depth += 1
                node = node.left
            return depth

        left_depth = get_left_depth(root.left)
        right_depth = get_left_depth(root.right)

        if left_depth == right_depth:
            # If the leftmost depths of the left and right subtrees are equal,
            # it implies that the left subtree is a perfect binary tree of depth 'left_depth'.
            # The number of nodes in a perfect binary tree of depth D (number of nodes on leftmost path) is (2^D - 1).
            # Total nodes = 1 (root) + (nodes in perfect left subtree) + (nodes in right subtree)
            # Nodes in perfect left subtree = (1 << left_depth) - 1
            # So, 1 + ((1 << left_depth) - 1) + countNodes(root.right)
            # Simplified: (1 << left_depth) + countNodes(root.right)
            return (1 << left_depth) + self.countNodes(root.right)
        else: # left_depth > right_depth
            # If the leftmost depth of the left subtree is greater than that of the right,
            # it implies that the right subtree is a perfect binary tree of depth 'right_depth'.
            # The number of nodes in a perfect binary tree of depth D is (2^D - 1).
            # Total nodes = 1 (root) + (nodes in left subtree) + (nodes in perfect right subtree)
            # Nodes in perfect right subtree = (1 << right_depth) - 1
            # So, 1 + countNodes(root.left) + ((1 << right_depth) - 1)
            # Simplified: (1 << right_depth) + countNodes(root.left)
            return (1 << right_depth) + self.countNodes(root.left)