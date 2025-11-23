class Solution:
    def bonus(self, n: int, leadership: List[List[int]], operations: List[List[int]]) -> List[int]:
        MOD = 10**9 + 7
        tree = [[] for _ in range(n + 1)]
        parent = [0] * (n + 1)
        for u, v in leadership:
            tree[u].append(v)
            parent[v] = u

        coins = [0] * (n + 1)
        res = []

        for op in operations:
            if op[0] == 1:
                v, amount = op[1], op[2]
                coins[v] += amount
                p = parent[v]
                while p != 0:
                    coins[p] += amount
                    p = parent[p]
            elif op[0] == 2:
                v, amount = op[1], op[2]
                stack = [v]
                total = 0
                while stack:
                    node = stack.pop()
                    total += coins[node]
                    for child in tree[node]:
                        stack.append(child)
                res.append(total % MOD)
            elif op[0] == 3:
                v = op[1]
                stack = [v]
                total = 0
                while stack:
                    node = stack.pop()
                    total += coins[node]
                    for child in tree[node]:
                        stack.append(child)
                res.append(total % MOD)
                coins[v] += op[2]
                p = parent[v]
                while p != 0:
                    coins[p] += op[2]
                    p = parent[p]
        return res