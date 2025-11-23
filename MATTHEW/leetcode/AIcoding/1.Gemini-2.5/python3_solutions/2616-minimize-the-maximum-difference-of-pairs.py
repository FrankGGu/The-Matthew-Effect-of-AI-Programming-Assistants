class Solution:
    def minimizeMax(self, nums: list[int], p: int) -> int:
        n = len(nums)
        nums.sort()

        def check(max_diff: int) -> bool:
            count = 0
            i = 0
            while i < n - 1:
                if nums[i+1] - nums[i] <= max_diff:
                    count += 1
                    i += 2  # Skip the next element as it's used in a pair
                else:
                    i += 1
                if count >= p:
                    return True
            return count >= p

        low = 0
        high = nums[-1] - nums[0]
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans