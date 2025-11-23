def maxAreaOfDiagonalRectangle(lengths):
    max_area = 0
    n = len(lengths)

    for i in range(n):
        for j in range(i + 1, n):
            width = abs(lengths[j] - lengths[i])
            height = min(lengths[i], lengths[j])
            area = width * height
            max_area = max(max_area, area)

    return max_area