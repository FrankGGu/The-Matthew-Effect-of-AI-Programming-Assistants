class Solution:
    def maxCount(self, root: Optional[TreeNode], ops: List[List[int]]) -> int:
        if not root:
            return 0

        min_x = float('inf')
        max_y = float('-inf')

        for op in ops:
            x, y = op
            if x < min_x:
                min_x = x
            if y > max_y:
                max_y = y

        return min_x * (max_y - min_x + 1) if min_x <= max_y else 0