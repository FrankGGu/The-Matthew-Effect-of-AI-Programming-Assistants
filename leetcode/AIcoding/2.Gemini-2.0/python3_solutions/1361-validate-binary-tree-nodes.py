class Solution:
    def validateBinaryTreeNodes(self, n: int, leftChild: List[int], rightChild: List[int]) -> bool:
        in_degree = [0] * n
        for i in range(n):
            if leftChild[i] != -1:
                in_degree[leftChild[i]] += 1
            if rightChild[i] != -1:
                in_degree[rightChild[i]] += 1

        root_count = 0
        root = -1
        for i in range(n):
            if in_degree[i] == 0:
                root_count += 1
                root = i

        if root_count != 1:
            return False

        visited = [False] * n
        stack = [root]
        count = 0
        while stack:
            node = stack.pop()
            if visited[node]:
                return False
            visited[node] = True
            count += 1

            if leftChild[node] != -1:
                stack.append(leftChild[node])
            if rightChild[node] != -1:
                stack.append(rightChild[node])

        return count == n