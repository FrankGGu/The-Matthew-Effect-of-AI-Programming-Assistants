def solve():
    n, k = map(int, input().split())
    points = []
    for _ in range(n):
        x, y = map(int, input().split())
        points.append((x, y))

    max_dist = 0
    for i in range(n):
        for j in range(n):
            dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])

            x1, y1 = points[i]
            x2, y2 = points[j]

            max_dist = max(max_dist, dist)

    print(max_dist)

solve()