from collections import deque

class Solution:
    def zigzagLevelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        result = []
        if not root:
            return result

        queue = deque([root])
        left_to_right = True

        while queue:
            level_size = len(queue)
            current_level_nodes = []
            for _ in range(level_size):
                node = queue.popleft()
                current_level_nodes.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            if not left_to_right:
                current_level_nodes.reverse()

            result.append(current_level_nodes)
            left_to_right = not left_to_right

        return result