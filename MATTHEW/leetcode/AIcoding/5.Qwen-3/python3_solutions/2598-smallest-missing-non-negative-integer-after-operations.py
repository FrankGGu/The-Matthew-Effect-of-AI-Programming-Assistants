class Solution:
    def findSmallestInteger(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        i = 1
        while True:
            if count[i] == 0:
                return i
            count[i] -= 1
            i += 1