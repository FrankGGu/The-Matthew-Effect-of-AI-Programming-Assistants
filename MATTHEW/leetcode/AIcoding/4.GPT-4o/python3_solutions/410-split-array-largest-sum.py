class Solution:
    def splitArray(self, nums: List[int], k: int) -> int:
        def canSplit(mid):
            count, total = 1, 0
            for num in nums:
                total += num
                if total > mid:
                    count += 1
                    total = num
            return count <= k

        left, right = max(nums), sum(nums)
        while left < right:
            mid = (left + right) // 2
            if canSplit(mid):
                right = mid
            else:
                left = mid + 1
        return left