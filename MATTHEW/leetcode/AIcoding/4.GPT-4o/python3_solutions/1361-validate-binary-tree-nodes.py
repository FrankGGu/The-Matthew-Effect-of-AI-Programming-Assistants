class Solution:
    def validateBinaryTreeNodes(self, n: int, leftChild: List[int], rightChild: List[int]) -> bool:
        parent = [-1] * n
        for i in range(n):
            if leftChild[i] != -1:
                if parent[leftChild[i]] != -1:
                    return False
                parent[leftChild[i]] = i
            if rightChild[i] != -1:
                if parent[rightChild[i]] != -1:
                    return False
                parent[rightChild[i]] = i

        root_count = parent.count(-1)
        if root_count != 1:
            return False

        visited = [False] * n

        def dfs(node):
            if node == -1:
                return
            if visited[node]:
                return False
            visited[node] = True
            return dfs(leftChild[node]) and dfs(rightChild[node])

        return dfs(parent.index(-1)) and all(visited)