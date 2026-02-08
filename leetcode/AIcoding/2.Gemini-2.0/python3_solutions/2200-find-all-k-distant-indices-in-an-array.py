class Solution:
    def findKDistantIndices(self, nums: List[int], key: int, k: int) -> List[int]:
        result = []
        for i in range(len(nums)):
            for j in range(len(nums)):
                if abs(i - j) <= k and nums[j] == key:
                    result.append(i)
                    break
        return result