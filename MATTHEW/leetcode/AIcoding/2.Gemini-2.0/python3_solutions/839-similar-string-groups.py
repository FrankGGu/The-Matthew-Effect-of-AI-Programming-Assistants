class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        def is_similar(s1, s2):
            diff = 0
            for i in range(len(s1)):
                if s1[i] != s2[i]:
                    diff += 1
            return diff == 0 or diff == 2

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                parent[root_x] = root_y

        n = len(strs)
        parent = list(range(n))
        count = n

        for i in range(n):
            for j in range(i + 1, n):
                if is_similar(strs[i], strs[j]):
                    if find(i) != find(j):
                        union(i, j)
                        count -= 1

        return count