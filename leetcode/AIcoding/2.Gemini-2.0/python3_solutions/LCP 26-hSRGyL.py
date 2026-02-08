def solve():
    n = int(input())
    stations = []
    for _ in range(n):
        stations.append(list(map(int, input().split())))

    def dist(p1, p2):
        return ((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)**0.5

    def check(radius):
        adj = [[] for _ in range(n)]
        for i in range(n):
            for j in range(i + 1, n):
                if dist(stations[i], stations[j]) <= 2 * radius:
                    adj[i].append(j)
                    adj[j].append(i)

        color = [-1] * n
        def dfs(node, c):
            color[node] = c
            for neighbor in adj[node]:
                if color[neighbor] == -1:
                    if not dfs(neighbor, 1 - c):
                        return False
                elif color[neighbor] == c:
                    return False
            return True

        for i in range(n):
            if color[i] == -1:
                if not dfs(i, 0):
                    return False
        return True

    low = 0
    high = 10**5
    ans = high
    for _ in range(100):
        mid = (low + high) / 2
        if check(mid):
            ans = mid
            high = mid
        else:
            low = mid

    print(ans)

solve()