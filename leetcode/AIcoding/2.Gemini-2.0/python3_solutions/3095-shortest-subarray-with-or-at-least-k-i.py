def shortestSubarray(nums, k):
    n = len(nums)
    prefix_sums = [0] * (n + 1)
    for i in range(n):
        prefix_sums[i + 1] = prefix_sums[i] | nums[i]

    if prefix_sums[n] < k:
        return -1

    min_len = n
    for i in range(n):
        for j in range(i, n):
            if (prefix_sums[j + 1] | nums[i]) >= k:
                min_len = min(min_len, j - i + 1)
                break

    for i in range(n):
        for j in range(i,n):
          current_or = 0
          for l in range(i,j+1):
            current_or |= nums[l]
          if current_or >= k:
            min_len = min(min_len, j - i + 1)
            break
    return min_len