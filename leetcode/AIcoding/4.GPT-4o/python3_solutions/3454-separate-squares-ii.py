def separateSquares(nums):
    n = len(nums)
    if n == 0:
        return []

    left = 0
    right = n - 1
    result = [0] * n

    while left <= right:
        if nums[right] < 0:
            result[left] = nums[right]
            left += 1
            right -= 1
        else:
            result[right] = nums[right]
            right -= 1

    return result