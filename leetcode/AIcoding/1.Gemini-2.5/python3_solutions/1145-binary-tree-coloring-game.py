class Solution:
    def btreeGameWinningStrategy(self, root: Optional[TreeNode], n: int, x: int) -> bool:

        node_x = None

        def find_x_and_count(node):
            nonlocal node_x
            if not node:
                return 0

            if node.val == x:
                node_x = node

            left_count = find_x_and_count(node.left)
            right_count = find_x_and_count(node.right)

            return 1 + left_count + right_count

        # This initial call will find node_x and also calculate total nodes (which is n, but we don't strictly need it here)
        # However, the find_x_and_count function is designed to return the size of the subtree rooted at 'node'.
        # We need to call it on node_x's children AFTER node_x is found.
        # So, we separate finding x and counting subtrees.

        def find_node_x(node):
            nonlocal node_x
            if not node:
                return
            if node.val == x:
                node_x = node
                return
            find_node_x(node.left)
            if node_x:
                return
            find_node_x(node.right)

        def count_subtree_nodes(node):
            if not node:
                return 0
            return 1 + count_subtree_nodes(node.left) + count_subtree_nodes(node.right)

        find_node_x(root)

        left_subtree_size = count_subtree_nodes(node_x.left)
        right_subtree_size = count_subtree_nodes(node_x.right)

        parent_side_size = n - 1 - left_subtree_size - right_subtree_size

        if left_subtree_size > n // 2 or \
           right_subtree_size > n // 2 or \
           parent_side_size > n // 2:
            return True
        else:
            return False