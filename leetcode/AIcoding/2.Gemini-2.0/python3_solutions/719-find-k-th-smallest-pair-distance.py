class Solution:
    def smallestDistancePair(self, nums: List[int], k: int) -> int:
        nums.sort()

        def count(mid):
            cnt = 0
            j = 0
            for i in range(len(nums)):
                while j < len(nums) and nums[j] - nums[i] <= mid:
                    j += 1
                cnt += j - i - 1
            return cnt

        left, right = 0, nums[-1] - nums[0]
        while left < right:
            mid = (left + right) // 2
            if count(mid) < k:
                left = mid + 1
            else:
                right = mid
        return left