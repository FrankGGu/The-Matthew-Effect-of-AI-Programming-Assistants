def cutTree(heights: List[int], k: int) -> int:
    left, right = 1, max(heights)
    while left < right:
        mid = (left + right) // 2
        if sum(max(0, h - mid) for h in heights) < k:
            right = mid
        else:
            left = mid + 1
    return left - 1