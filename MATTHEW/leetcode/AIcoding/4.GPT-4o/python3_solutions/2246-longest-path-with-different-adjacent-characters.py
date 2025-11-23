class Solution:
    def longestPath(self, parent: List[int], s: str) -> int:
        tree = defaultdict(list)
        for i in range(1, len(parent)):
            tree[parent[i]].append(i)

        def dfs(node):
            max1, max2 = 0, 0
            for child in tree[node]:
                length = dfs(child)
                if s[child] != s[node]:
                    if length > max1:
                        max1, max2 = length, max1
                    elif length > max2:
                        max2 = length
            self.result = max(self.result, max1 + max2 + 1)
            return max1 + 1

        self.result = 1
        dfs(0)
        return self.result