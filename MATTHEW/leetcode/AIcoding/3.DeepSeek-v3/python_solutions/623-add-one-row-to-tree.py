class Solution:
    def addOneRow(self, root: Optional[TreeNode], val: int, depth: int) -> Optional[TreeNode]:
        if depth == 1:
            new_root = TreeNode(val)
            new_root.left = root
            return new_root

        from collections import deque
        queue = deque([root])
        current_depth = 1

        while queue and current_depth < depth - 1:
            level_size = len(queue)
            for _ in range(level_size):
                node = queue.popleft()
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            current_depth += 1

        for node in queue:
            new_left = TreeNode(val)
            new_left.left = node.left
            node.left = new_left

            new_right = TreeNode(val)
            new_right.right = node.right
            node.right = new_right

        return root