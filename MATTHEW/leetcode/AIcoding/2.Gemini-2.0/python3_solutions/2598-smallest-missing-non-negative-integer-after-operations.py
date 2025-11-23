class Solution:
    def findSmallestInteger(self, nums: list[int], value: int) -> int:
        counts = [0] * value
        for num in nums:
            counts[num % value] += 1

        min_idx = 0
        for i in range(1, value):
            if counts[i] < counts[min_idx]:
                min_idx = i

        return counts[min_idx] * value + min_idx