from collections import deque

class Solution:
    def sortItems(self, n: int, m: int, group: List[int], beforeItems: List[List[int]]) -> List[int]:
        group_id = m
        for i in range(n):
            if group[i] == -1:
                group[i] = group_id
                group_id += 1

        item_graph = [[] for _ in range(n)]
        item_indegree = [0] * n

        group_graph = [[] for _ in range(group_id)]
        group_indegree = [0] * group_id

        for curr in range(n):
            for prev in beforeItems[curr]:
                item_graph[prev].append(curr)
                item_indegree[curr] += 1
                if group[curr] != group[prev]:
                    group_graph[group[prev]].append(group[curr])
                    group_indegree[group[curr]] += 1

        def topological_sort(graph, indegree):
            queue = deque()
            for i in range(len(graph)):
                if indegree[i] == 0:
                    queue.append(i)
            result = []
            while queue:
                node = queue.popleft()
                result.append(node)
                for neighbor in graph[node]:
                    indegree[neighbor] -= 1
                    if indegree[neighbor] == 0:
                        queue.append(neighbor)
            return result if len(result) == len(graph) else []

        group_order = topological_sort(group_graph, group_indegree)
        if not group_order:
            return []

        item_order = topological_sort(item_graph, item_indegree)
        if not item_order:
            return []

        group_to_items = defaultdict(list)
        for item in item_order:
            group_to_items[group[item]].append(item)

        result = []
        for group_id in group_order:
            result += group_to_items[group_id]
        return result