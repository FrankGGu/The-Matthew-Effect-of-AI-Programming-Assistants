def canFinish(n: int, prerequisites: List[List[int]]) -> bool:
    from collections import defaultdict, deque

    graph = defaultdict(list)
    indegree = [0] * n

    for dest, src in prerequisites:
        graph[src].append(dest)
        indegree[dest] += 1

    queue = deque([i for i in range(n) if indegree[i] == 0])
    count = 0

    while queue:
        node = queue.popleft()
        count += 1
        for neighbor in graph[node]:
            indegree[neighbor] -= 1
            if indegree[neighbor] == 0:
                queue.append(neighbor)

    return count == n