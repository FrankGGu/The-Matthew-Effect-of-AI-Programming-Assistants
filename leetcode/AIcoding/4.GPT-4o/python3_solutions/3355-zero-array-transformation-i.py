def canTransform(nums):
    total = sum(nums)
    return total % 3 == 0 and all(-1 <= num <= 1 for num in nums)