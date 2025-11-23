class Solution:
    def numSimilarGroups(self, strs: List[str]) -> int:
        from collections import defaultdict, deque

        def get_neighbors(s):
            neighbors = set()
            for i in range(len(s)):
                for j in range(i + 1, len(s)):
                    s_list = list(s)
                    s_list[i], s_list[j] = s_list[j], s_list[i]
                    neighbors.add(''.join(s_list))
            return neighbors

        visited = set()
        groups = 0
        queue = deque()

        for s in strs:
            if s not in visited:
                groups += 1
                queue.append(s)
                visited.add(s)
                while queue:
                    current = queue.popleft()
                    for neighbor in get_neighbors(current):
                        if neighbor not in visited:
                            visited.add(neighbor)
                            queue.append(neighbor)

        return groups