class Solution:
    def minimumLimit(self, nums: list[int], maxOperations: int) -> int:
        def check(limit: int) -> bool:
            ops_needed = 0
            for num_balls in nums:
                if num_balls > limit:
                    ops_needed += (num_balls - 1) // limit
            return ops_needed <= maxOperations

        low = 1
        high = max(nums)
        ans = high

        while low <= high:
            mid = (low + high) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans