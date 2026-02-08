class Solution:
    def findKOr(self, nums: List[int], k: int) -> int:
        result = 0
        for i in range(31, -1, -1):
            count = 0
            for num in nums:
                if num & (1 << i):
                    count += 1
            if count >= k:
                result |= (1 << i)
        return result