from collections import deque

class Solution:
    def widthOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        max_width = 0
        queue = deque()
        queue.append((root, 0))

        while queue:
            level_length = len(queue)
            _, first_pos = queue[0]
            for _ in range(level_length):
                node, pos = queue.popleft()
                if node.left:
                    queue.append((node.left, 2 * pos))
                if node.right:
                    queue.append((node.right, 2 * pos + 1))
            max_width = max(max_width, pos - first_pos + 1)

        return max_width