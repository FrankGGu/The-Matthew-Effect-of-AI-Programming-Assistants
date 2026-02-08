def minArraySum(nums):
    nums.sort()
    total_sum = 0
    for i, num in enumerate(nums):
        total_sum += num * (i + 1)
    return total_sum