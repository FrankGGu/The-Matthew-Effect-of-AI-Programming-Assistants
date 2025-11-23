import heapq
from collections import defaultdict

class Solution:
    def kthLargestLevelSum(self, root: Optional[TreeNode], k: int) -> int:
        if not root:
            return 0

        level_sums = defaultdict(int)
        queue = [(root, 0)]

        while queue:
            node, level = queue.pop(0)
            level_sums[level] += node.val

            if node.left:
                queue.append((node.left, level + 1))
            if node.right:
                queue.append((node.right, level + 1))

        sums = list(level_sums.values())
        if len(sums) < k:
            return -1

        return heapq.nlargest(k, sums)[-1]