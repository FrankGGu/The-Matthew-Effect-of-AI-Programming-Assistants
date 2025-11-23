class Solution:
    def deepestLeavesSum(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        queue = [root]
        while queue:
            level_sum = 0
            next_level = []
            for node in queue:
                level_sum += node.val
                if node.left:
                    next_level.append(node.left)
                if node.right:
                    next_level.append(node.right)
            if not next_level:
                return level_sum
            queue = next_level
        return 0