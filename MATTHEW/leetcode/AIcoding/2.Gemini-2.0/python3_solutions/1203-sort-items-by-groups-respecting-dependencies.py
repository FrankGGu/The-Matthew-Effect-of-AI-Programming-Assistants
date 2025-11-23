from collections import defaultdict, deque

def sortItems(n: int, m: int, group: list[int], beforeItems: list[list[int]]) -> list[int]:
    for i in range(n):
        if group[i] == -1:
            group[i] = m
            m += 1

    item_graph = defaultdict(list)
    item_indegree = [0] * n
    group_graph = defaultdict(list)
    group_indegree = [0] * m

    item_to_group = defaultdict(list)
    for i in range(n):
        item_to_group[group[i]].append(i)

    for i in range(n):
        for before in beforeItems[i]:
            item_graph[before].append(i)
            item_indegree[i] += 1
            if group[i] != group[before]:
                group_graph[group[before]].append(group[i])
                group_indegree[group[i]] += 1

    def topological_sort(graph, indegree, items):
        queue = deque([item for item in items if indegree[item] == 0])
        result = []
        while queue:
            node = queue.popleft()
            result.append(node)
            for neighbor in graph[node]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)
        return result if len(result) == len(items) else []

    item_order = topological_sort(item_graph, item_indegree, range(n))
    group_order = topological_sort(group_graph, group_indegree, range(m))

    if not item_order or not group_order:
        return []

    group_items = defaultdict(list)
    for item in item_order:
        group_items[group[item]].append(item)

    result = []
    for group_id in group_order:
        result.extend(group_items[group_id])

    return result