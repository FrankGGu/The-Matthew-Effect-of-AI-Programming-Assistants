def minimumSize(nums: list[int], maxOperations: int) -> int:
    left, right = 1, max(nums)
    while left < right:
        mid = (left + right) // 2
        ops = 0
        for num in nums:
            ops += (num - 1) // mid
        if ops <= maxOperations:
            right = mid
        else:
            left = mid + 1
    return left