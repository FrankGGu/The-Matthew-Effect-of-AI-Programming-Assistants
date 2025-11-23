def maximumPoints(edges, guesses, k):
    n = len(edges) + 1
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u - 1].append(v - 1)
        graph[v - 1].append(u - 1)

    guess_set = set()
    for u, v in guesses:
        guess_set.add((u - 1, v - 1))

    count = 0
    def dfs(node, parent):
        nonlocal count
        for neighbor in graph[node]:
            if neighbor != parent:
                if (node, neighbor) in guess_set:
                    count += 1
                dfs(neighbor, node)

    dfs(0, -1)
    initial_count = count

    result = 0
    if initial_count >= k:
        result += 1

    def dfs2(node, parent, current_count):
        nonlocal result
        for neighbor in graph[node]:
            if neighbor != parent:
                new_count = current_count
                if (node, neighbor) in guess_set:
                    new_count -= 1
                if (neighbor, node) in guess_set:
                    new_count += 1
                if new_count >= k:
                    result += 1
                dfs2(neighbor, node, new_count)

    dfs2(0, -1, initial_count)
    return result