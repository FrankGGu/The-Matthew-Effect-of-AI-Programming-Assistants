def maximumInvitations(favorite):
    n = len(favorite)
    graph = [[] for _ in range(n)]
    for i, f in enumerate(favorite):
        graph[f].append(i)

    def dfs(node, visited, stack):
        visited[node] = True
        stack[node] = True
        for neighbor in graph[node]:
            if not visited[neighbor]:
                if dfs(neighbor, visited, stack):
                    return True
            elif stack[neighbor]:
                return True
        stack[node] = False
        return False

    def find_cycle(node, parent):
        for neighbor in graph[node]:
            if neighbor != parent:
                visited[neighbor] = True
                path.append(neighbor)
                if dfs2(neighbor, node):
                    return True
                path.pop()
        return False

    def dfs2(node, parent):
        if node == start:
            return True
        for neighbor in graph[node]:
            if neighbor != parent:
                if dfs2(neighbor, node):
                    return True
        return False

    def get_cycle_length(start_node):
        visited = [False] * n
        path = [start_node]
        visited[start_node] = True

        def find_cycle_length(node, parent):
            for neighbor in graph[node]:
                if neighbor != parent:
                    if neighbor == start_node:
                        return len(path)
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        path.append(neighbor)
                        length = find_cycle_length(neighbor, node)
                        if length > 0:
                            return length
                        path.pop()
            return 0
        return find_cycle_length(start_node, -1)

    def get_max_path(node):
        max_len = 0
        for neighbor in graph[node]:
            if neighbor not in cycle_nodes:
                max_len = max(max_len, 1 + get_max_path(neighbor))
        return max_len

    visited = [False] * n
    cycles = []
    for i in range(n):
        if not visited[i]:
            start = i
            path = [i]
            visited[i] = True
            if find_cycle(i, -1):
                cycle = []
                current = path[-1]
                first = favorite[current]
                cycle.append(first)
                while first != current:
                    current = favorite[current]
                    cycle.append(current)
                cycles.append(cycle)

    cycle_sum = 0
    for cycle in cycles:
        cycle_sum += len(cycle)

    pair_sum = 0
    pairs = set()
    for i in range(n):
        if favorite[favorite[i]] == i and (i, favorite[i]) not in pairs and (favorite[i], i) not in pairs:
            pairs.add((i, favorite[i]))
            cycle_nodes = set()
            for cyc in cycles:
                cycle_nodes.update(cyc)

            pair_sum += 2 + get_max_path(i) + get_max_path(favorite[i])

    return max(cycle_sum, pair_sum)