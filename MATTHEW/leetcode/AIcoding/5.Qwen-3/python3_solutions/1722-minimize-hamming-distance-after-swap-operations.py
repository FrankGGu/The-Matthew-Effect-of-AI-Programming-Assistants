class Solution:
    def minimizeHammingDistance(self, arr: List[int], pairs: List[List[int]]) -> int:
        from collections import defaultdict, deque

        def build_graph(pairs):
            graph = defaultdict(list)
            for u, v in pairs:
                graph[u].append(v)
                graph[v].append(u)
            return graph

        def bfs(start, visited, group):
            queue = deque([start])
            visited.add(start)
            while queue:
                node = queue.popleft()
                group.append(node)
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)

        graph = build_graph(pairs)
        visited = set()
        groups = []

        for i in range(len(arr)):
            if i not in visited:
                group = []
                bfs(i, visited, group)
                groups.append(group)

        from collections import Counter

        for group in groups:
            counts = Counter()
            for idx in group:
                counts[arr[idx]] += 1
            for idx in group:
                counts[arr[idx]] -= 1

        for group in groups:
            values = [arr[i] for i in group]
            counts = Counter(values)
            for i in group:
                if counts[arr[i]] > 0:
                    counts[arr[i]] -= 1
                else:
                    return -1

        return sum(1 for i in range(len(arr)) if arr[i] != arr[i])