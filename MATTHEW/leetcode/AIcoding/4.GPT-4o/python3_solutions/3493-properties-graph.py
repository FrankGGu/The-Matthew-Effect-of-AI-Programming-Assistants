class Solution:
    def propertiesGraph(self, properties: List[List[int]]) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        indegree = defaultdict(int)

        for a, b in properties:
            graph[a].append(b)
            indegree[b] += 1
            if a not in indegree:
                indegree[a] = 0

        queue = deque([node for node in indegree if indegree[node] == 0])
        result = []

        while queue:
            node = queue.popleft()
            result.append(node)
            for neighbor in graph[node]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        return result if len(result) == len(indegree) else []