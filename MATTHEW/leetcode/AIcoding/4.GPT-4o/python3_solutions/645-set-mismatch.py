def findErrorNums(nums):
    n = len(nums)
    expected_sum = n * (n + 1) // 2
    actual_sum = sum(set(nums))
    duplicate = sum(nums) - actual_sum
    missing = expected_sum - actual_sum
    return [duplicate, missing]