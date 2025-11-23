class Solution:
    def minOperations(self, nums: List[int]) -> int:
        count = 0
        for num in nums:
            if num == 1:
                continue
            elif num == 0:
                return -1
            else:
                count += 1
        return count + (1 if count > 0 else 0)