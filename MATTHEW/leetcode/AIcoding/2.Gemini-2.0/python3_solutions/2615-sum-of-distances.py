def sumOfDistances(nums):
    prefix_sum = {}
    count = {}
    result = [0] * len(nums)

    for i, num in enumerate(nums):
        if num not in prefix_sum:
            prefix_sum[num] = 0
            count[num] = 0

        result[i] = prefix_sum[num] + count[num] * num
        prefix_sum[num] += num * (i + 1)
        count[num] += (i + 1)

    prefix_sum = {}
    count = {}

    for i in range(len(nums) - 1, -1, -1):
        num = nums[i]
        if num not in prefix_sum:
            prefix_sum[num] = 0
            count[num] = 0

        result[i] += prefix_sum[num] - count[num] * num
        prefix_sum[num] += num * (len(nums) - i)
        count[num] += (len(nums) - i)

    return result