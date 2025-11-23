class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        def are_similar(s1, s2):
            diff = []
            for a, b in zip(s1, s2):
                if a != b:
                    diff.append((a, b))
            return len(diff) == 2 and diff[0] == diff[1][::-1] or len(diff) == 0

        def dfs(s):
            visited.add(s)
            for neighbor in graph[s]:
                if neighbor not in visited:
                    dfs(neighbor)

        graph = {s: [] for s in strs}
        for i in range(len(strs)):
            for j in range(i + 1, len(strs)):
                if are_similar(strs[i], strs[j]):
                    graph[strs[i]].append(strs[j])
                    graph[strs[j]].append(strs[i])

        visited = set()
        count = 0
        for s in strs:
            if s not in visited:
                dfs(s)
                count += 1

        return count