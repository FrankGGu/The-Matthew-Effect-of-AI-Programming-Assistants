class Solution:
    def lexicalOrder(self, n: int) -> List[int]:
        result = []

        def dfs(current):
            if current > n:
                return
            result.append(current)
            for i in range(10):
                dfs(current * 10 + i)

        for i in range(1, 10):
            dfs(i)

        return result