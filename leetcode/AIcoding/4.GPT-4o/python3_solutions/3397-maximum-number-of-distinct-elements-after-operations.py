def maxDistinctNumbers(nums, k):
    from collections import Counter

    count = Counter(nums)
    distinct_count = len(count)
    extra = sum(v - 1 for v in count.values() if v > 1)

    if k >= extra:
        return distinct_count + (k - extra)
    else:
        return distinct_count + k