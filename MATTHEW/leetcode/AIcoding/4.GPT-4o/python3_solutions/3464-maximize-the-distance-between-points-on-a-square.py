def maxDistance(points):
    max_dist = 0
    for i in range(len(points)):
        for j in range(len(points)):
            if i != j:
                dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
                max_dist = max(max_dist, dist)
    return max_dist