class Solution:
    def longestSpecialPath(self, parent: List[int], s: str) -> int:
        n = len(parent)
        children = [[] for _ in range(n)]
        for i in range(1, n):
            children[parent[i]].append(i)

        self.res = 1

        def dfs(node):
            max1 = max2 = 0
            for child in children[node]:
                path = dfs(child)
                if s[child] != s[node]:
                    if path > max1:
                        max2 = max1
                        max1 = path
                    elif path > max2:
                        max2 = path
            self.res = max(self.res, max1 + max2 + 1)
            return max1 + 1

        dfs(0)
        return self.res