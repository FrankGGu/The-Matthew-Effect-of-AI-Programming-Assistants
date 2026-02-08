class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        def is_similar(s1, s2):
            diff = sum(a != b for a, b in zip(s1, s2))
            return diff == 0 or diff == 2 and sorted(s1) == sorted(s2)

        def dfs(s, visited):
            visited.add(s)
            for neighbor in strs:
                if neighbor not in visited and is_similar(s, neighbor):
                    dfs(neighbor, visited)

        visited = set()
        groups = 0

        for s in strs:
            if s not in visited:
                dfs(s, visited)
                groups += 1

        return groups