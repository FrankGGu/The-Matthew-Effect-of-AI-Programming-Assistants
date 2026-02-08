def solve():
    n = int(input())
    m = int(input())
    routes = []
    for _ in range(m):
        routes.append(list(map(int, input().split())))

    max_connections = 0
    for i in range(1, n + 1):
        in_count = 0
        out_count = 0
        for route in routes:
            if route[1] == i:
                in_count += 1
            if route[0] == i:
                out_count += 1
        if in_count == m - out_count:
            max_connections = max(max_connections, in_count)

    if max_connections == 0:
        print(-1)
    else:
        print(max_connections)

solve()