class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        def is_similar(s1, s2):
            diff = 0
            for i in range(len(s1)):
                if s1[i] != s2[i]:
                    diff += 1
            return diff == 0 or diff == 2

        def find(parent, i):
            if parent[i] == i:
                return i
            parent[i] = find(parent, parent[i])
            return parent[i]

        def union(parent, i, j):
            root_i = find(parent, i)
            root_j = find(parent, j)
            if root_i != root_j:
                parent[root_i] = root_j

        n = len(strs)
        parent = list(range(n))
        count = n

        for i in range(n):
            for j in range(i + 1, n):
                if is_similar(strs[i], strs[j]):
                    if find(parent, i) != find(parent, j):
                        union(parent, i, j)
                        count -= 1

        return count