class Solution:
    def lexicalOrder(self, n: int) -> list[int]:
        res = []
        def dfs(num):
            if num > n:
                return
            res.append(num)
            for i in range(10):
                if num * 10 + i <= n:
                    dfs(num * 10 + i)
                else:
                    break

        for i in range(1, 10):
            if i <= n:
                dfs(i)
            else:
                break
        return res