def maximumSubarraySum(nums: list[int], x: int) -> int:
    n = len(nums)
    max_sum = -float('inf')

    for i in range(n):
        temp_nums = []
        for j in range(n):
            if nums[j] != x:
                temp_nums.append(nums[j])

        if not temp_nums:
            max_sum = max(max_sum, 0)
            continue

        curr_sum = 0
        curr_max = -float('inf')

        for k in range(len(temp_nums)):
            curr_sum += temp_nums[k]
            curr_max = max(curr_max, curr_sum)
            if curr_sum < 0:
                curr_sum = 0

        max_sum = max(max_sum, curr_max)

    return max_sum