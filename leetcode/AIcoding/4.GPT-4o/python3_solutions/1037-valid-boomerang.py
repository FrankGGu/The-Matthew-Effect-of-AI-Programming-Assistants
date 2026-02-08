def isBoomerang(points):
    return not (points[0] == points[1] or points[0] == points[2] or points[1] == points[2]) and \
           (points[0][0] - points[1][0]) * (points[0][1] - points[2][1]) != (points[0][1] - points[1][1]) * (points[0][0] - points[2][0])