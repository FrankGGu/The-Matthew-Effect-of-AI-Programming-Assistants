def solve():
    n = int(input())
    x = {}
    y = {}
    for _ in range(n):
        a, b = map(int, input().split())
        if a not in x:
            x[a] = 0
        if b not in y:
            y[b] = 0
        x[a] += 1
        y[b] += 1

    ans = 0
    for a in x:
        for b in y:
            ans += (x[a] - 1) * (y[b] - 1)
    print(ans)

solve()