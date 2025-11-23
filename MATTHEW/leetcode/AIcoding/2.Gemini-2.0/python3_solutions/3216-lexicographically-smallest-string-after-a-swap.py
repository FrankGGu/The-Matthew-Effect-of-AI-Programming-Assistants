class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: List[List[int]]) -> str:
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

        components = {}
        for i in range(n):
            root = find(i)
            if root not in components:
                components[root] = []
            components[root].append(i)

        result = list(s)
        for root, indices in components.items():
            chars = sorted([s[i] for i in indices])
            indices.sort()
            for i, char in enumerate(chars):
                result[indices[i]] = char

        return "".join(result)