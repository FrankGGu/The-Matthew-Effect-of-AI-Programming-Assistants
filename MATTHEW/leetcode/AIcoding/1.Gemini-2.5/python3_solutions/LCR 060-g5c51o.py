import collections

class Solution:
    def topKFrequent(self, nums: list[int], k: int) -> list[int]:
        counts = collections.Counter(nums)

        # Get the k most common elements.
        # most_common(k) returns a list of (element, count) tuples.
        top_k_items = counts.most_common(k)

        # Extract only the elements from the tuples.
        result = [item[0] for item in top_k_items]

        return result