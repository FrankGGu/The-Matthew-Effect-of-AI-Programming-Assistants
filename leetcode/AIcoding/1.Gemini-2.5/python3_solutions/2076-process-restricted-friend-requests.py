class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def processFriendRequests(self, n: int, restrictions: list[list[int]], requests: list[list[int]]) -> list[bool]:
        dsu = DSU(n)
        results = []

        for u, v in requests:
            root_u = dsu.find(u)
            root_v = dsu.find(v)

            if root_u == root_v:
                results.append(True)
                continue

            can_merge = True
            for x, y in restrictions:
                root_x = dsu.find(x)
                root_y = dsu.find(y)

                if (root_x == root_u and root_y == root_v) or \
                   (root_x == root_v and root_y == root_u):
                    can_merge = False
                    break

            if can_merge:
                dsu.union(u, v)
                results.append(True)
            else:
                results.append(False)

        return results