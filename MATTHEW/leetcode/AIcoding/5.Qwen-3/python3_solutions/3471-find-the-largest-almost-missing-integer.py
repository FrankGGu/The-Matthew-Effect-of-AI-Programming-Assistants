class Solution:
    def findLargestAlmostMissingInteger(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        freq = [0] * (len(nums) + 2)
        for num in count:
            if num >= 0 and num <= len(nums):
                freq[num] += 1

        for i in range(len(nums), -1, -1):
            if freq[i] == 0:
                return i
        return -1