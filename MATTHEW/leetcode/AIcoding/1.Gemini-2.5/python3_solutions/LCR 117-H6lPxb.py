class Solution:
    def numSimilarGroups(self, strs: list[str]) -> int:
        n = len(strs)
        parent = list(range(n))

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                parent[root_i] = root_j
                return True
            return False

        def is_similar(s1, s2):
            diff_count = 0
            for i in range(len(s1)):
                if s1[i] != s2[i]:
                    diff_count += 1
            return diff_count == 0 or diff_count == 2

        for i in range(n):
            for j in range(i + 1, n):
                if is_similar(strs[i], strs[j]):
                    union(i, j)

        groups = set()
        for i in range(n):
            groups.add(find(i))

        return len(groups)