class Solution:
    def reachableNodes(self, edges: List[List[int]], restricted: List[int]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        restricted_set = set(restricted)
        visited = set()
        queue = deque([0])
        visited.add(0)

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if neighbor not in visited and neighbor not in restricted_set:
                    visited.add(neighbor)
                    queue.append(neighbor)

        return len(visited)