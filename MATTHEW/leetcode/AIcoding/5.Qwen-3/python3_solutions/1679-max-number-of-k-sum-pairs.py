from collections import Counter

class Solution:
    def maxKSumPairs(self, nums: List[int], k: int) -> int:
        count = Counter(nums)
        pairs = 0
        for num in count:
            complement = k - num
            if complement in count:
                if num == complement:
                    pairs += count[num] // 2
                else:
                    pairs += min(count[num], count[complement])
                    count[complement] = 0
        return pairs