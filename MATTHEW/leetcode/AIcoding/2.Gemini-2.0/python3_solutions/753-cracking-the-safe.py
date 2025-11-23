class Solution:
    def crackSafe(self, n: int, k: int) -> str:
        if n == 1 and k == 1:
            return "0"

        total = k**n
        visited = set()
        start = "0" * (n - 1)
        result = ""

        def dfs(node):
            nonlocal result
            for i in range(k):
                neighbor = node + str(i)
                if neighbor not in visited:
                    visited.add(neighbor)
                    dfs(neighbor[1:])
                    result += str(i)

        dfs(start)
        return result + start