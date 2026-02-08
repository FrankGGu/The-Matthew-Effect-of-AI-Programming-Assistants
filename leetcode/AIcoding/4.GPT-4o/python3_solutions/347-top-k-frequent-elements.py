from collections import Counter
import heapq

def topKFrequent(nums, k):
    count = Counter(nums)
    return [item for item, freq in heapq.nlargest(k, count.items(), key=lambda x: x[1])]