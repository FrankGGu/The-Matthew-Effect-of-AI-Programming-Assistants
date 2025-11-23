def findInteger(nums):
    total = sum(nums)
    return total - (len(nums) * (len(nums) + 1)) // 2