class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n

    def find(self, u):
        if self.parent[u] != u:
            self.parent[u] = self.find(self.parent[u])
        return self.parent[u]

    def union(self, u, v):
        rootU = self.find(u)
        rootV = self.find(v)
        if rootU != rootV:
            if self.rank[rootU] > self.rank[rootV]:
                self.parent[rootV] = rootU
            elif self.rank[rootU] < self.rank[rootV]:
                self.parent[rootU] = rootV
            else:
                self.parent[rootV] = rootU
                self.rank[rootU] += 1

class Solution:
    def numFriendRequests(self, ages: List[int], restrictions: List[List[int]]) -> List[int]:
        n = len(ages)
        uf = UnionFind(n)
        results = [0] * n

        for i in range(n):
            for j in range(n):
                if i != j and self.is_friend_request_valid(ages[i], ages[j], restrictions):
                    uf.union(i, j)

        for i in range(n):
            results[i] = sum(1 for j in range(n) if uf.find(i) == uf.find(j) and i != j)

        return results

    def is_friend_request_valid(self, age1, age2, restrictions):
        if age1 <= 14 or age2 <= 14:
            return False
        for min_age, max_age in restrictions:
            if (age1 < min_age and age2 >= max_age) or (age2 < min_age and age1 >= max_age):
                return False
        return True