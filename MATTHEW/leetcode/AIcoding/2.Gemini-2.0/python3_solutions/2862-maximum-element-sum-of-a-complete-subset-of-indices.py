def maximumSum(nums):
    n = len(nums)
    sums = {}
    for i in range(1, int(n**0.5) + 1):
        if i * i <= n:
            sums[i*i] = sums.get(i*i, 0) + nums[i*i - 1]

    ans = 0

    for i in range(1, n + 1):
        cur_sum = 0
        j = 1
        while j * j <= i:
            if i % j == 0:
                if j * j == i:
                    cur_sum += nums[i-1]
                else:
                    cur_sum += nums[j-1]
                    cur_sum += nums[i//j - 1]
            j += 1
        ans = max(ans, cur_sum)

    return ans