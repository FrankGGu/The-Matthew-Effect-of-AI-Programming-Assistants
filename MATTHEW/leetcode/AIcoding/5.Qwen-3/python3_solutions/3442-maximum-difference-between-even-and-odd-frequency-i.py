class Solution:
    def evenOddDifference(self, nums):
        from collections import Counter
        freq = Counter(nums)
        even = 0
        odd = 0
        for num in freq:
            if freq[num] % 2 == 0:
                even += num
            else:
                odd += num
        return even - odd