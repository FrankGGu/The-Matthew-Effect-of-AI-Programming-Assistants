def solve():
    n, m = map(int, input().split())
    adj = [[] for _ in range(n + 1)]
    for _ in range(m):
        u, v = map(int, input().split())
        adj[u].append(v)
        adj[v].append(u)

    q = int(input())
    for _ in range(q):
        start, end, k = map(int, input().split())

        def bfs(start_node, end_node, max_nodes):
            queue = [(start_node, [start_node])]
            visited = set()
            while queue:
                node, path = queue.pop(0)
                if node == end_node:
                    return path
                if len(path) > max_nodes:
                    continue
                if node in visited:
                    continue
                visited.add(node)
                for neighbor in adj[node]:
                    queue.append((neighbor, path + [neighbor]))
            return None

        path = bfs(start, end, k + 1)
        if path:
            print("YES")
        else:
            print("NO")

solve()