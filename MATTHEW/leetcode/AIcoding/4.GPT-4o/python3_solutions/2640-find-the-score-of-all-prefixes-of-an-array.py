class Solution:
    def findPrefixScore(self, nums: List[int]) -> List[int]:
        prefix_max = 0
        score = 0
        result = []

        for num in nums:
            prefix_max = max(prefix_max, num)
            score += num + prefix_max
            result.append(score)

        return result