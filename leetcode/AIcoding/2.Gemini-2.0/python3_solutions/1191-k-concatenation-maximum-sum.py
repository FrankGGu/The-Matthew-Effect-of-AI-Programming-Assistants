def kConcatenationMaxSum(arr, k):
    MOD = 10**9 + 7
    n = len(arr)
    max_so_far = 0
    current_max = 0
    for i in range(n):
        current_max = max(arr[i], current_max + arr[i])
        max_so_far = max(max_so_far, current_max)

    if k == 1:
        return max_so_far % MOD

    prefix_sum = 0
    max_prefix_sum = 0
    for i in range(n):
        prefix_sum += arr[i]
        max_prefix_sum = max(max_prefix_sum, prefix_sum)

    suffix_sum = 0
    max_suffix_sum = 0
    for i in range(n - 1, -1, -1):
        suffix_sum += arr[i]
        max_suffix_sum = max(max_suffix_sum, suffix_sum)

    total_sum = sum(arr)
    if total_sum > 0:
        return max(max_so_far, max_prefix_sum + max_suffix_sum + (k - 2) * total_sum) % MOD
    else:
        return max(max_so_far, max_prefix_sum + max_suffix_sum) % MOD