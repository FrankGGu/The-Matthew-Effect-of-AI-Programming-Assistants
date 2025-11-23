def canCompleteTraining(n: int, dependencies: List[List[int]], k: int) -> bool:
    from collections import defaultdict, deque

    graph = defaultdict(list)
    indegree = [0] * n

    for dep in dependencies:
        graph[dep[0]].append(dep[1])
        indegree[dep[1]] += 1

    queue = deque()
    for i in range(n):
        if indegree[i] == 0:
            queue.append(i)

    count = 0
    while queue:
        count += 1
        if count > k:
            return False
        current = queue.popleft()
        for neighbor in graph[current]:
            indegree[neighbor] -= 1
            if indegree[neighbor] == 0:
                queue.append(neighbor)

    return count == n