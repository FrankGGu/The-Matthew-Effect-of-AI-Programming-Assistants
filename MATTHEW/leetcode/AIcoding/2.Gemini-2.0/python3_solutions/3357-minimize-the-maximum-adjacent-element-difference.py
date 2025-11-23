class Solution:
    def minimizeMax(self, nums: list[int], p: int) -> int:
        nums.sort()
        n = len(nums)

        def count_pairs(diff):
            count = 0
            i = 0
            while i < n - 1:
                if nums[i+1] - nums[i] <= diff:
                    count += 1
                    i += 2
                else:
                    i += 1
            return count

        left = 0
        right = nums[-1] - nums[0]

        while left < right:
            mid = (left + right) // 2
            if count_pairs(mid) >= p:
                right = mid
            else:
                left = mid + 1

        return left