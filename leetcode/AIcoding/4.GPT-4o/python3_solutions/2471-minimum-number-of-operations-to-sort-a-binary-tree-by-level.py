from collections import deque

class Solution:
    def minimumOperations(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        level = 0
        total_operations = 0
        queue = deque([root])

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

            sorted_nodes = sorted(current_level_nodes)
            operations = sum(1 for i in range(level_size) if current_level_nodes[i] != sorted_nodes[i])
            total_operations += operations

            level += 1

        return total_operations