def countPoints(points, queries):
    from collections import defaultdict
    res = []

    for x, y, r in queries:
        count = sum((px - x) ** 2 + (py - y) ** 2 <= r ** 2 for px, py in points)
        res.append(count)

    return res