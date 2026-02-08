def maxCandies(candies, k):
    def canAllocate(mid):
        count = 0
        for c in candies:
            count += c // mid
        return count >= k

    left, right = 1, max(candies)
    while left < right:
        mid = (left + right + 1) // 2
        if canAllocate(mid):
            left = mid
        else:
            right = mid - 1
    return left