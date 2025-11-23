import collections

class Solution:
    def minScore(self, n: int, roads: List[List[int]]) -> int:
        graph = collections.defaultdict(list)
        for u, v, w in roads:
            graph[u].append((v, w))
            graph[v].append((u, w))

        min_score = float('inf')
        visited = set()
        queue = collections.deque([1])

        while queue:
            node = queue.popleft()
            visited.add(node)
            for neighbor, weight in graph[node]:
                if neighbor not in visited:
                    queue.append(neighbor)
                min_score = min(min_score, weight)

        return min_score