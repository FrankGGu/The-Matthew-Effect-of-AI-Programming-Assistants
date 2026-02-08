def max_difference_even_odd(nums: list[int]) -> int:
    n = len(nums)
    freq = {}
    for num in nums:
        freq[num] = freq.get(num, 0) + 1

    even_freq = {}
    odd_freq = {}

    for num, count in freq.items():
        if count % 2 == 0:
            even_freq[num] = count
        else:
            odd_freq[num] = count

    even_nums = sorted(even_freq.keys())
    odd_nums = sorted(odd_freq.keys())

    if not even_nums:
        return -1

    max_diff = -float('inf')

    for i in range(1 << len(even_nums)):
        even_sum = 0
        even_count = 0

        for j in range(len(even_nums)):
            if (i >> j) & 1:
                even_sum += even_freq[even_nums[j]] * even_nums[j]
                even_count += even_freq[even_nums[j]]

        for k in range(1 << len(odd_nums)):
            odd_sum = 0
            odd_count = 0

            for l in range(len(odd_nums)):
                if (k >> l) & 1:
                    odd_sum += odd_freq[odd_nums[l]] * odd_nums[l]
                    odd_count += odd_freq[odd_nums[l]]

            if even_count + odd_count > 0:
                max_diff = max(max_diff, even_sum - odd_sum)

    return max_diff