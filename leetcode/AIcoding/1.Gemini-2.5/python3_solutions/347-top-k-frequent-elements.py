import collections

class Solution:
    def topKFrequent(self, nums: list[int], k: int) -> list[int]:
        counts = collections.Counter(nums)

        # Sort items by frequency in descending order and take the first k elements
        # item[0] is the number, item[1] is its frequency
        sorted_items = sorted(counts.items(), key=lambda item: item[1], reverse=True)

        # Extract the numbers from the top k frequent items
        result = [item[0] for item in sorted_items[:k]]

        return result