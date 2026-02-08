def find_longest_equal_subarray(nums, k):
    n = len(nums)
    max_len = 0
    for i in range(n):
        for j in range(i, n):
            subarray = nums[i:j+1]
            counts = {}
            for num in subarray:
                counts[num] = counts.get(num, 0) + 1

            if not counts:
                continue

            max_freq = 0
            for num in counts:
                max_freq = max(max_freq, counts[num])

            if len(subarray) - max_freq <= k:
                max_len = max(max_len, len(subarray))

    return max_len