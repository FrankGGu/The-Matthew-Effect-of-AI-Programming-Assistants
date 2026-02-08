class Solution:
    def minimizeMax(self, nums: list[int], p: int) -> int:
        if p == 0:
            return 0

        nums.sort()
        n = len(nums)

        def check(max_diff):
            count = 0
            i = 0
            while i < n - 1:
                if nums[i+1] - nums[i] <= max_diff:
                    count += 1
                    i += 2
                else:
                    i += 1
                if count >= p:
                    return True
            return False

        low = 0
        high = nums[n-1] - nums[0]
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans