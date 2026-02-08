from collections import deque

class Solution:
    def isCousins(self, root: TreeNode, x: int, y: int) -> bool:
        q = deque([(root, 0, None)]) # (node, depth, parent_node)

        x_info = None # (depth, parent_node)
        y_info = None # (depth, parent_node)

        while q:
            current_node, current_depth, parent_node = q.popleft()

            if current_node.val == x:
                x_info = (current_depth, parent_node)
            elif current_node.val == y:
                y_info = (current_depth, parent_node)

            if x_info and y_info:
                break

            if current_node.left:
                q.append((current_node.left, current_depth + 1, current_node))
            if current_node.right:
                q.append((current_node.right, current_depth + 1, current_node))

        return x_info[0] == y_info[0] and x_info[1] != y_info[1]