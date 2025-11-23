def defendSpaceCity(obstacle: list[list[int]]) -> int:
    obstacle.sort()
    intervals = []
    for start, end in obstacle:
        intervals.append([start - end, start + end])
    intervals.sort(key=lambda x: x[1])
    ans = 0
    right = float('-inf')
    for left, right_bound in intervals:
        if left > right:
            ans += 1
            right = right_bound
    return ans