def maxBuilding(n: int, restrictions: list[list[int]]) -> int:
    restrictions.sort()
    restrictions.insert(0, [1, 0])
    restrictions.append([n, n])
    m = len(restrictions)
    for i in range(1, m):
        restrictions[i][1] = min(restrictions[i][1], restrictions[i - 1][1] + restrictions[i][0] - restrictions[i - 1][0])
    for i in range(m - 2, -1, -1):
        restrictions[i][1] = min(restrictions[i][1], restrictions[i + 1][1] + restrictions[i + 1][0] - restrictions[i][0])
    ans = 0
    for i in range(1, m):
        a, b = restrictions[i - 1]
        x, y = restrictions[i]
        l = x - a
        h = abs(y - b)
        if h >= l:
            ans = max(ans, max(y, b) + (l - 1) // 2)
        else:
            ans = max(ans, max(y, b) + (l - h) // 2 + h)
    return ans