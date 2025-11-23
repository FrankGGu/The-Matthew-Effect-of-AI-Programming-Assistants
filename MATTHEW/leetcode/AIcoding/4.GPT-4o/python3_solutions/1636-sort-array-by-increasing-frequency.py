from collections import Counter

def frequencySort(nums):
    count = Counter(nums)
    return sorted(nums, key=lambda x: (count[x], -x))