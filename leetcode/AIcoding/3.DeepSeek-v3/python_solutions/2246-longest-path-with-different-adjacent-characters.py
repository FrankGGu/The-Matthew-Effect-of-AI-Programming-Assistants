class Solution:
    def longestPath(self, parent: List[int], s: str) -> int:
        tree = defaultdict(list)
        for i in range(1, len(parent)):
            tree[parent[i]].append(i)

        self.res = 1

        def dfs(node):
            max1 = max2 = 0
            for child in tree[node]:
                path_length = dfs(child)
                if s[child] != s[node]:
                    if path_length > max1:
                        max2 = max1
                        max1 = path_length
                    elif path_length > max2:
                        max2 = path_length
            self.res = max(self.res, max1 + max2 + 1)
            return max1 + 1

        dfs(0)
        return self.res