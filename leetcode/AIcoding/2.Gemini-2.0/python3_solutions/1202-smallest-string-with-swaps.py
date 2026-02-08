class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: list[list[int]]) -> str:
        n = len(s)
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

        for i, j in pairs:
            union(i, j)

        groups = {}
        for i in range(n):
            root = find(i)
            if root not in groups:
                groups[root] = []
            groups[root].append(i)

        result = list(s)
        for root, indices in groups.items():
            chars = [s[i] for i in indices]
            chars.sort()
            indices.sort()
            for i, char in zip(indices, chars):
                result[i] = char

        return "".join(result)