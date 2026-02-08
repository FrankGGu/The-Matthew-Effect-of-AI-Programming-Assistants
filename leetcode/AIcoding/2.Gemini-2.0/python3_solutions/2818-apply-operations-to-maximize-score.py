def maxScore(nums, x):
    n = len(nums)
    odd = 0
    even = 0

    if nums[0] % 2 == 0:
        even = nums[0]
    else:
        odd = nums[0]

    for i in range(1, n):
        if nums[i] % 2 == 0:
            if even > 0:
                even += nums[i]
            else:
                even = max(odd - x + nums[i], nums[i])
            odd = max(odd, even - nums[i] - x if even - nums[i] - x > 0 else 0)
        else:
            if odd > 0:
                odd += nums[i]
            else:
                odd = max(even - x + nums[i], nums[i])
            even = max(even, odd - nums[i] - x if odd - nums[i] - x > 0 else 0)

    return max(odd, even)