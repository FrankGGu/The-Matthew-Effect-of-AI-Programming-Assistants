def earliestAndLatest(n: int, F: List[List[int]]) -> List[int]:
    from collections import defaultdict

    graph = defaultdict(list)
    for a, b in F:
        graph[a].append(b)
        graph[b].append(a)

    def dfs(node, depth, visited):
        visited.add(node)
        if depth == n:
            return 1

        count = 0
        for neighbor in graph[node]:
            if neighbor not in visited:
                count += dfs(neighbor, depth + 1, visited)
        visited.remove(node)
        return count

    earliest = float('inf')
    latest = float('-inf')

    for start in range(1, n + 1):
        visited = set()
        current_count = dfs(start, 1, visited)
        earliest = min(earliest, current_count)
        latest = max(latest, current_count)

    return [earliest, latest]