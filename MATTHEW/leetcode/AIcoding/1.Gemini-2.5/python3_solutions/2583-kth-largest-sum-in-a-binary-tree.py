import collections

class Solution:
    def kthLargestLevelSum(self, root: Optional[TreeNode], k: int) -> int:
        if not root:
            return 0 

        level_sums = []
        queue = collections.deque([root])

        while queue:
            current_level_sum = 0
            level_size = len(queue)
            for _ in range(level_size):
                node = queue.popleft()
                current_level_sum += node.val
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            level_sums.append(current_level_sum)

        level_sums.sort(reverse=True)

        return level_sums[k-1]