class Solution:
    def reverseOddLevels(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        from collections import deque

        if not root:
            return None

        q = deque([root])
        level = 0

        while q:
            size = len(q)
            level_nodes = []

            for _ in range(size):
                node = q.popleft()
                level_nodes.append(node)

                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)

            if level % 2 == 1:
                left, right = 0, len(level_nodes) - 1
                while left < right:
                    level_nodes[left].val, level_nodes[right].val = level_nodes[right].val, level_nodes[left].val
                    left += 1
                    right -= 1

            level += 1

        return root