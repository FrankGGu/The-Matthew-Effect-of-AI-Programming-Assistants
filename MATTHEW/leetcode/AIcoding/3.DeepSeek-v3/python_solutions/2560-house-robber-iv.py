class Solution:
    def minCapability(self, nums: List[int], k: int) -> int:
        left, right = min(nums), max(nums)

        def is_possible(mid):
            count = 0
            last_taken = -2
            for i in range(len(nums)):
                if nums[i] <= mid and i > last_taken + 1:
                    count += 1
                    last_taken = i
                    if count >= k:
                        return True
            return count >= k

        while left < right:
            mid = (left + right) // 2
            if is_possible(mid):
                right = mid
            else:
                left = mid + 1
        return left