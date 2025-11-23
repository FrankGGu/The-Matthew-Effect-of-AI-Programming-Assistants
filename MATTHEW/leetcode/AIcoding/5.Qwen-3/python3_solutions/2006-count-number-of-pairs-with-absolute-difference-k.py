class Solution:
    def countKDifference(self, nums: List[int], k: int) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        result = 0
        for num in nums:
            result += count[num - k]
            result += count[num + k]
            count[num] += 1
        return result