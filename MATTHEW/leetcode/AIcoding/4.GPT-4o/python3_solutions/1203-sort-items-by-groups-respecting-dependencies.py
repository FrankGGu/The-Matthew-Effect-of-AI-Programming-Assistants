from collections import defaultdict, deque

class Solution:
    def sortItems(self, n: int, m: int, group: List[int], beforeItems: List[List[int]]) -> List[int]:
        def topological_sort(graph, indegree):
            q = deque()
            for i in range(len(indegree)):
                if indegree[i] == 0:
                    q.append(i)
            order = []
            while q:
                node = q.popleft()
                order.append(node)
                for neighbor in graph[node]:
                    indegree[neighbor] -= 1
                    if indegree[neighbor] == 0:
                        q.append(neighbor)
            return order if len(order) == len(indegree) else []

        item_group = defaultdict(list)
        group_indegree = [0] * m
        item_indegree = [0] * n

        for i in range(n):
            if group[i] == -1:
                group[i] = m
                m += 1
            item_group[group[i]].append(i)

        group_graph = defaultdict(list)
        for i in range(n):
            for before in beforeItems[i]:
                if group[i] != group[before]:
                    group_graph[group[before]].append(group[i])
                    group_indegree[group[i]] += 1

        item_graph = defaultdict(list)
        for i in range(n):
            for before in beforeItems[i]:
                item_graph[before].append(i)
                item_indegree[i] += 1

        group_order = topological_sort(group_graph, group_indegree)
        item_order = topological_sort(item_graph, item_indegree)

        if not group_order or not item_order:
            return []

        group_to_items = defaultdict(list)
        for item in item_order:
            group_to_items[group[item]].append(item)

        result = []
        for g in group_order:
            result.extend(group_to_items[g])

        return result