from collections import deque

class Solution:
    def minimumOperations(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        queue = deque([root])
        operations = 0

        while queue:
            level_size = len(queue)
            current_level = []

            for _ in range(level_size):
                node = queue.popleft()
                current_level.append(node.val)
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            sorted_level = sorted(current_level)
            value_to_pos = {val: idx for idx, val in enumerate(current_level)}

            for i in range(len(current_level)):
                if current_level[i] != sorted_level[i]:
                    correct_val = sorted_level[i]
                    current_pos = value_to_pos[correct_val]

                    current_level[i], current_level[current_pos] = current_level[current_pos], current_level[i]
                    value_to_pos[current_level[current_pos]] = current_pos
                    value_to_pos[current_level[i]] = i

                    operations += 1

        return operations