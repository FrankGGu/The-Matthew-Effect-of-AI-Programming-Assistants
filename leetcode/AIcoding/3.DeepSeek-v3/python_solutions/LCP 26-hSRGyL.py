class Solution:
    def minTransfers(self, transactions: List[List[int]]) -> int:
        from collections import defaultdict

        balance = defaultdict(int)
        for u, v, amount in transactions:
            balance[u] -= amount
            balance[v] += amount

        debts = [amount for amount in balance.values() if amount != 0]
        n = len(debts)

        def dfs(start):
            while start < n and debts[start] == 0:
                start += 1
            if start == n:
                return 0
            res = float('inf')
            for i in range(start + 1, n):
                if debts[start] * debts[i] < 0:
                    debts[i] += debts[start]
                    res = min(res, 1 + dfs(start + 1))
                    debts[i] -= debts[start]
            return res

        return dfs(0)