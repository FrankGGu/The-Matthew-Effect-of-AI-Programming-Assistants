class Solution:
    def validateBinaryTreeNodes(self, leftChild: List[int], rightChild: List[int]) -> bool:
        from collections import deque

        n = len(leftChild)
        visited = [False] * n
        queue = deque()
        root = -1

        for i in range(n):
            if leftChild[i] == -1 and rightChild[i] == -1:
                if root == -1:
                    root = i
                else:
                    return False

        if root == -1:
            return False

        queue.append(root)
        visited[root] = True

        while queue:
            node = queue.popleft()
            for child in [leftChild[node], rightChild[node]]:
                if child == -1:
                    continue
                if visited[child]:
                    return False
                visited[child] = True
                queue.append(child)

        return all(visited)