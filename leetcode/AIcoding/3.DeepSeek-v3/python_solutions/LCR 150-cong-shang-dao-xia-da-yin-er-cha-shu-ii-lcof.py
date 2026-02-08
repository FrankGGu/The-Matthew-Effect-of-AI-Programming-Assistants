class Solution:
    def decorateRecord(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root:
            return []
        res = []
        queue = [root]
        left_to_right = True
        while queue:
            level_size = len(queue)
            level = []
            for _ in range(level_size):
                node = queue.pop(0)
                if left_to_right:
                    level.append(node.val)
                else:
                    level.insert(0, node.val)
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            res.append(level)
            left_to_right = not left_to_right
        return res