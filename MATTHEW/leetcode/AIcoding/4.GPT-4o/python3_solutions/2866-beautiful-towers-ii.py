def beautifulTowers(n: int, heights: List[int]) -> int:
    heights.sort()
    left, right = 0, n - 1
    result = 0

    while left < right:
        if heights[left] < heights[right]:
            result += 1
            left += 1
            right -= 1
        else:
            left += 1

    return result