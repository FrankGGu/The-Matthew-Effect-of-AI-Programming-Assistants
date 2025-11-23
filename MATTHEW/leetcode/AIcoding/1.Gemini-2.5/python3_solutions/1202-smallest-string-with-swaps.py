import collections

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
            elif self.rank[root_j] < self.rank[root_i]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: list[list[int]]) -> str:
        n = len(s)
        dsu = DSU(n)

        for u, v in pairs:
            dsu.union(u, v)

        components = collections.defaultdict(list)
        for i in range(n):
            root = dsu.find(i)
            components[root].append(i)

        s_list = list(s)

        for root in components:
            indices_in_component = components[root]

            chars_in_component = [s_list[i] for i in indices_in_component]

            chars_in_component.sort()
            indices_in_component.sort()

            for k in range(len(indices_in_component)):
                s_list[indices_in_component[k]] = chars_in_component[k]

        return "".join(s_list)