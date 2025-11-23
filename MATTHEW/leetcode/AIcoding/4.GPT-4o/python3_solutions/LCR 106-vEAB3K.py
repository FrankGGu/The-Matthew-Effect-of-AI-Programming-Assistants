def isBipartite(graph):
    color = {}

    def bfs(start):
        queue = [start]
        color[start] = 0
        while queue:
            node = queue.pop(0)
            for neighbor in graph[node]:
                if neighbor not in color:
                    color[neighbor] = 1 - color[node]
                    queue.append(neighbor)
                elif color[neighbor] == color[node]:
                    return False
        return True

    for i in range(len(graph)):
        if i not in color:
            if not bfs(i):
                return False
    return True