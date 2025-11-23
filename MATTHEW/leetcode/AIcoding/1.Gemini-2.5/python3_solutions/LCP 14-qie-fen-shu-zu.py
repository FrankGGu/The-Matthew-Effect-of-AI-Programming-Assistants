class Solution:
    def splitArray(self, nums: list[int], k: int) -> int:
        def check(max_sum: int) -> bool:
            num_subarrays = 1
            current_sum = 0
            for x in nums:
                if current_sum + x > max_sum:
                    num_subarrays += 1
                    current_sum = x
                else:
                    current_sum += x
            return num_subarrays <= k

        low = max(nums)
        high = sum(nums)
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans