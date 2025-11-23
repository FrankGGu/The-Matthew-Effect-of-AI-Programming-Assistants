class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        def is_similar(s1, s2):
            diffs = 0
            for a, b in zip(s1, s2):
                if a != b:
                    diffs += 1
                if diffs > 2:
                    return False
            return diffs in (0, 2)

        def dfs(index):
            visited[index] = True
            for i in range(len(strs)):
                if not visited[i] and is_similar(strs[index], strs[i]):
                    dfs(i)

        visited = [False] * len(strs)
        groups = 0

        for i in range(len(strs)):
            if not visited[i]:
                dfs(i)
                groups += 1

        return groups