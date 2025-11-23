class Solution:
    def splitArray(self, nums: list[int], k: int) -> int:
        def check(max_sum_allowed: int) -> bool:
            current_sum = 0
            num_subarrays = 1
            for num in nums:
                if current_sum + num <= max_sum_allowed:
                    current_sum += num
                else:
                    num_subarrays += 1
                    current_sum = num
                    if num_subarrays > k:
                        return False
            return True

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