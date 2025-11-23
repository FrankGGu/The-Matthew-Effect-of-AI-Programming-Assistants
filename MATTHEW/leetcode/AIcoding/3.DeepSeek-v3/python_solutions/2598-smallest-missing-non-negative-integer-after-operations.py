class Solution:
    def findSmallestInteger(self, nums: List[int], value: int) -> int:
        from collections import defaultdict
        freq = defaultdict(int)
        for num in nums:
            mod = num % value
            freq[mod] += 1

        mex = 0
        while True:
            mod = mex % value
            if freq[mod] > 0:
                freq[mod] -= 1
                mex += 1
            else:
                return mex