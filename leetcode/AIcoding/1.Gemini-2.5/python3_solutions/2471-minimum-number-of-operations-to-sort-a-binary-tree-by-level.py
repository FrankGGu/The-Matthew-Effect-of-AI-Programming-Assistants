import collections

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minimumOperations(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        total_swaps = 0
        q = collections.deque([root])

        while q:
            level_size = len(q)
            current_level_values = []
            for _ in range(level_size):
                node = q.popleft()
                current_level_values.append(node.val)
                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)

            n = len(current_level_values)
            if n <= 1:
                continue

            pairs = []
            for i in range(n):
                pairs.append((current_level_values[i], i))

            pairs.sort()

            target_pos = [0] * n
            for i in range(n):
                original_idx = pairs[i][1]
                target_pos[original_idx] = i

            visited = [False] * n
            level_swaps = 0
            for i in range(n):
                if visited[i] or target_pos[i] == i:
                    continue

                cycle_len = 0
                j = i
                while not visited[j]:
                    visited[j] = True
                    j = target_pos[j]
                    cycle_len += 1

                level_swaps += (cycle_len - 1)

            total_swaps += level_swaps

        return total_swaps