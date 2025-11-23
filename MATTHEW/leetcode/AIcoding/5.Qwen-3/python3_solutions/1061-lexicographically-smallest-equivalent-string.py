class Solution:
    def smallestEquivalentString(self, A: str, B: str, S: str) -> str:
        parent = list(range(26))

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            px = find(x)
            py = find(y)
            if px != py:
                parent[max(px, py)] = min(px, py)

        for a, b in zip(A, B):
            x = ord(a) - ord('a')
            y = ord(b) - ord('a')
            union(x, y)

        res = []
        for c in S:
            idx = ord(c) - ord('a')
            root = find(idx)
            res.append(chr(root + ord('a')))

        return ''.join(res)