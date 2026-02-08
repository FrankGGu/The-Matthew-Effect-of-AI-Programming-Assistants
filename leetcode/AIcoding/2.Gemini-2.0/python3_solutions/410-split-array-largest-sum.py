class Solution:
    def splitArray(self, nums: List[int], k: int) -> int:
        def possible(threshold):
            count = 1
            current_sum = 0
            for num in nums:
                if current_sum + num > threshold:
                    count += 1
                    current_sum = num
                else:
                    current_sum += num
            return count <= k

        left = max(nums)
        right = sum(nums)

        while left < right:
            mid = (left + right) // 2
            if possible(mid):
                right = mid
            else:
                left = mid + 1

        return left