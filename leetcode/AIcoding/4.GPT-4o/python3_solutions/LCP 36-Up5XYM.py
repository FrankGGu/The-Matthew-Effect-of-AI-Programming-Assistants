def maxEqualFreq(nums):
    from collections import Counter
    freq = Counter(nums)
    count = Counter(freq.values())
    max_freq = max(count)

    if len(count) == 1:
        return len(nums)

    if len(count) == 2:
        (f1, c1), (f2, c2) = count.items()
        if (c1 == 1 and (f1 == 1 or f1 - f2 == 1)) or (c2 == 1 and (f2 == 1 or f2 - f1 == 1)):
            return len(nums)

    return len(nums) - 1