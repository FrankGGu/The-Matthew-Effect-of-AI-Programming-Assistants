class Solution:
    def splitArray(self, nums: List[int], m: int) -> int:
        left, right = max(nums), sum(nums)

        while left < right:
            mid = (left + right) // 2
            total, count = 0, 1
            for num in nums:
                if total + num > mid:
                    count += 1
                    total = num
                else:
                    total += num
            if count > m:
                left = mid + 1
            else:
                right = mid
        return left