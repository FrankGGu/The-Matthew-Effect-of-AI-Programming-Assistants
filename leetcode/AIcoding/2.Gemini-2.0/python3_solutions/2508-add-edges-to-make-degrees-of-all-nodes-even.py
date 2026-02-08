class Solution:
    def isPossible(self, n: int, edges: List[List[int]]) -> bool:
        degree = [0] * (n + 1)
        odd_nodes = []
        for u, v in edges:
            degree[u] += 1
            degree[v] += 1

        for i in range(1, n + 1):
            if degree[i] % 2 != 0:
                odd_nodes.append(i)

        if not odd_nodes:
            return True

        if len(odd_nodes) > 4:
            return False

        if len(odd_nodes) == 2:
            u, v = odd_nodes
            if (u, v) in [(a, b) for a, b in edges] or (v, u) in [(a, b) for a, b in edges]:
                for i in range(1, n + 1):
                    if i != u and i != v:
                        if (u, i) not in [(a, b) for a, b in edges] and (i, u) not in [(a, b) for a, b in edges] and (v, i) not in [(a, b) for a, b in edges] and (i, v) not in [(a, b) for a, b in edges]:
                            return True
                return False
            else:
                return True

        if len(odd_nodes) == 4:
            a, b, c, d = odd_nodes
            if (a, b) not in [(x, y) for x, y in edges] and (b, a) not in [(x, y) for x, y in edges] and (c, d) not in [(x, y) for x, y in edges] and (d, c) not in [(x, y) for x, y in edges]:
                return True
            if (a, c) not in [(x, y) for x, y in edges] and (c, a) not in [(x, y) for x, y in edges] and (b, d) not in [(x, y) for x, y in edges] and (d, b) not in [(x, y) for x, y in edges]:
                return True
            if (a, d) not in [(x, y) for x, y in edges] and (d, a) not in [(x, y) for x, y in edges] and (b, c) not in [(x, y) for x, y in edges] and (c, b) not in [(x, y) for x, y in edges]:
                return True
            return False

        return False