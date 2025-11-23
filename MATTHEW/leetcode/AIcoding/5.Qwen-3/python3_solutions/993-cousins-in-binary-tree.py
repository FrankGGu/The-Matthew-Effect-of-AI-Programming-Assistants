class Solution:
    def isCousins(self, root: TreeNode, x: int, y: int) -> bool:
        from collections import deque

        queue = deque([(root, None, 0)])

        x_info = None
        y_info = None

        while queue:
            node, parent, depth = queue.popleft()

            if node.val == x:
                x_info = (parent, depth)
            elif node.val == y:
                y_info = (parent, depth)

            if node.left:
                queue.append((node.left, node, depth + 1))
            if node.right:
                queue.append((node.right, node, depth + 1))

        return x_info[0] != y_info[0] and x_info[1] == y_info[1]