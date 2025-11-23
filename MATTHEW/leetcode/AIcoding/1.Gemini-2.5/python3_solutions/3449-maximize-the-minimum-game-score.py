class Solution:
    def maximizeTheMinimumGameScore(self, nums: list[int], k: int) -> int:
        def check(target: int) -> bool:
            """
            Checks if it's possible to split 'nums' into at least 'k' subarrays,
            where each subarray's sum is at least 'target'.
            """
            num_subarrays = 0
            current_sum = 0
            for x in nums:
                current_sum += x
                if current_sum >= target:
                    num_subarrays += 1
                    current_sum = 0
            return num_subarrays >= k

        # Binary search range for the minimum possible sum.
        # The minimum possible sum for a subarray is 0 (if nums can contain 0s or negative numbers).
        # The maximum possible sum for a subarray is the sum of all elements (if k=1).
        low = 0
        high = sum(nums)

        # 'ans' will store the maximum 'target' for which 'check' returns True.
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans