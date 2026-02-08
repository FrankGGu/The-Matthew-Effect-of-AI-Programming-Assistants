def findErrorNums(nums):
    n = len(nums)
    num_set = set()
    repeated = -1
    for num in nums:
        if num in num_set:
            repeated = num
        num_set.add(num)

    total_sum = n * (n + 1) // 2
    actual_sum = sum(num_set)

    missing = total_sum - actual_sum + repeated

    return [repeated, missing]