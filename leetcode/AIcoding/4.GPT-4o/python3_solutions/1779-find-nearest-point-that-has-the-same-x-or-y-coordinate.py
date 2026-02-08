def nearestValidPoint(x: int, y: int, points: List[List[int]]) -> int:
    nearest_index = -1
    min_distance = float('inf')

    for i, (px, py) in enumerate(points):
        if px == x or py == y:
            distance = abs(px - x) + abs(py - y)
            if distance < min_distance:
                min_distance = distance
                nearest_index = i

    return nearest_index