class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: List[List[int]]) -> str:
        parent = [i for i in range(len(s))]

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                parent[root_v] = root_u

        for u, v in pairs:
            union(u, v)

        groups = defaultdict(list)
        for i in range(len(s)):
            groups[find(i)].append(s[i])

        for key in groups:
            groups[key].sort(reverse=True)

        res = []
        for i in range(len(s)):
            res.append(groups[find(i)].pop())

        return ''.join(res)