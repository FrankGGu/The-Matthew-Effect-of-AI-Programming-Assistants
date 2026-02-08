class Solution:
    def minCapability(self, nums: List[int], k: int) -> int:
        def check(capability):
            count = 0
            robbed = False
            for num in nums:
                if num <= capability and not robbed:
                    count += 1
                    robbed = True
                else:
                    robbed = False
            return count >= k

        left, right = min(nums), max(nums)
        while left < right:
            mid = (left + right) // 2
            if check(mid):
                right = mid
            else:
                left = mid + 1
        return left