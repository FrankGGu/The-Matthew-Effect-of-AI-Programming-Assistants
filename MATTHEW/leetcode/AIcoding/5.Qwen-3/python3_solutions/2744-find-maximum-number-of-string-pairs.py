class Solution:
    def maximumNumberOfPairs(self, nums: List[int]) -> int:
        count = {}
        result = 0
        for num in nums:
            if num in count:
                count[num] += 1
            else:
                count[num] = 1
        for v in count.values():
            result += v // 2
        return result