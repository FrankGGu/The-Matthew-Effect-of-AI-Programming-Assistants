import collections
from typing import Optional

class Solution:
    def addOneRow(self, root: Optional[TreeNode], val: int, depth: int) -> Optional[TreeNode]:
        if depth == 1:
            new_root = TreeNode(val)
            new_root.left = root
            return new_root

        q = collections.deque([(root, 1)])

        while q:
            node, current_level = q.popleft()

            if current_level == depth - 1:
                original_left = node.left
                original_right = node.right

                new_left_node = TreeNode(val)
                new_left_node.left = original_left
                node.left = new_left_node

                new_right_node = TreeNode(val)
                new_right_node.right = original_right
                node.right = new_right_node
            elif current_level < depth - 1:
                if node.left:
                    q.append((node.left, current_level + 1))
                if node.right:
                    q.append((node.right, current_level + 1))

        return root