from typing import List

class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        n = len(strs)
        dsu = DSU(n)

        def is_similar(s1: str, s2: str) -> bool:
            # All words in strs have the same length, as per problem description.
            diff = 0
            for i in range(len(s1)):
                if s1[i] != s2[i]:
                    diff += 1
                if diff > 2:  # Optimization: if more than 2 differences, they cannot be similar
                    return False
            return diff == 0 or diff == 2

        for i in range(n):
            for j in range(i + 1, n):
                if is_similar(strs[i], strs[j]):
                    dsu.union(i, j)

        return dsu.count

class DSU:
    def __init__(self, n: int):
        self.parent = list(range(n))
        self.count = n  # Initialize with n disjoint sets

    def find(self, i: int) -> int:
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i: int, j: int) -> bool:
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_j] = root_i
            self.count -= 1  # Decrement count of disjoint sets
            return True
        return False