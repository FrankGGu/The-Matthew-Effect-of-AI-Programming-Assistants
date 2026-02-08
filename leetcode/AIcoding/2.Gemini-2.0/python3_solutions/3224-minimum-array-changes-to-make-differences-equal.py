from collections import Counter

def minChanges(nums, k):
    n = len(nums)
    ans = 0
    for i in range(k):
        counts = Counter()
        total = 0
        for j in range(i, n, k):
            counts[nums[j]] += 1
            total += 1
        max_freq = 0
        for count in counts.values():
            max_freq = max(max_freq, count)
        ans += total - max_freq
    return ans