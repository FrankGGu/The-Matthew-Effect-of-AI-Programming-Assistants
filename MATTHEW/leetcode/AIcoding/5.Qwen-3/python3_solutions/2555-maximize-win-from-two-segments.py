class Solution:
    def maxOperations(self, nums: List[int], k: int) -> int:
        from collections import Counter

        count = Counter(nums)
        operations = 0

        for num in count:
            complement = k - num
            if num < complement:
                operations += min(count[num], count[complement])
            elif num == complement:
                operations += count[num] // 2

        return operations