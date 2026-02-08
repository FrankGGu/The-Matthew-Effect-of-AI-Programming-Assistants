def maximumImportance(n: int, roads: List[List[int]]) -> int:
    from collections import Counter

    degree = Counter()

    for u, v in roads:
        degree[u] += 1
        degree[v] += 1

    sorted_degrees = sorted(degree.values(), reverse=True)
    importance = sum((i + 1) * sorted_degrees[i] for i in range(len(sorted_degrees)))

    return importance