import collections

class Solution:
    def validateBinaryTreeNodes(self, n: int, leftChild: list[int], rightChild: list[int]) -> bool:
        if n == 0:
            return True

        in_degree = [0] * n

        for i in range(n):
            if leftChild[i] != -1:
                in_degree[leftChild[i]] += 1
                if in_degree[leftChild[i]] > 1:
                    return False
            if rightChild[i] != -1:
                in_degree[rightChild[i]] += 1
                if in_degree[rightChild[i]] > 1:
                    return False

        root = -1
        for i in range(n):
            if in_degree[i] == 0:
                if root != -1:  # Found more than one root
                    return False
                root = i

        if root == -1:  # No root found (e.g., cycle where all nodes have parents)
            return False

        q = collections.deque([root])
        visited_count = 0
        visited = [False] * n
        visited[root] = True

        while q:
            u = q.popleft()
            visited_count += 1

            for v in [leftChild[u], rightChild[u]]:
                if v != -1:
                    if visited[v]:  # Cycle detected or node visited multiple times
                        return False
                    visited[v] = True
                    q.append(v)

        return visited_count == n