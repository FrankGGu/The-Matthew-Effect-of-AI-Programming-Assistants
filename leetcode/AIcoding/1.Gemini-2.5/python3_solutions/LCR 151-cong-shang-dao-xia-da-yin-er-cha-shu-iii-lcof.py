import collections

class Solution:
    def zigzagLevelOrder(self, root: TreeNode) -> list[list[int]]:
        result = []
        if not root:
            return result

        queue = collections.deque([root])
        level_num = 0

        while queue:
            level_size = len(queue)
            current_level_values = []

            for _ in range(level_size):
                node = queue.popleft()
                current_level_values.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            if level_num % 2 == 1:
                current_level_values.reverse()

            result.append(current_level_values)
            level_num += 1

        return result