class Solution:
    def reverseOddLevels(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return root

        queue = deque([root])
        level = 0

        while queue:
            size = len(queue)
            current_level = []
            for _ in range(size):
                node = queue.popleft()
                current_level.append(node)
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            if level % 2 == 1:
                left = 0
                right = len(current_level) - 1
                while left < right:
                    current_level[left].val, current_level[right].val = current_level[right].val, current_level[left].val
                    left += 1
                    right -= 1
            level += 1

        return root