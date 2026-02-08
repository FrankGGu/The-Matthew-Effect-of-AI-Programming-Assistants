from collections import deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minimumOperations(self, root: TreeNode) -> int:
        if not root:
            return 0

        q = deque([root])
        operations = 0

        while q:
            level_size = len(q)
            level_values = []
            for _ in range(level_size):
                node = q.popleft()
                level_values.append(node.val)
                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)

            arr = level_values
            n = len(arr)
            pos = {}
            for i in range(n):
                pos[arr[i]] = i

            sorted_arr = sorted(arr)

            visited = [False] * n

            for i in range(n):
                if visited[i] or arr[i] == sorted_arr[i]:
                    continue

                cycle_size = 0
                j = i
                while not visited[j]:
                    visited[j] = True
                    j = pos[sorted_arr[j]]
                    cycle_size += 1

                operations += (cycle_size - 1)

        return operations