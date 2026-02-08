class Solution:
    def maxChunksToSorted(self, arr: list[int]) -> int:
        chunks = 0
        current_max = 0
        for i, num in enumerate(arr):
            current_max = max(current_max, num)
            if current_max == i:
                chunks += 1
        return chunks