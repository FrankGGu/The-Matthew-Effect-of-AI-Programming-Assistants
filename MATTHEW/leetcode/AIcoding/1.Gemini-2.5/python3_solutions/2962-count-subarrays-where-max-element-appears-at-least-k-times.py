class Solution:
    def countSubarrays(self, nums: list[int], k: int) -> int:
        max_val = 0
        for num in nums:
            if num > max_val:
                max_val = num

        def count_subarrays_with_at_most_k_occurrences(k_limit: int) -> int:
            n = len(nums)
            ans = 0
            left = 0
            count_max_in_window = 0

            for right in range(n):
                if nums[right] == max_val:
                    count_max_in_window += 1

                while count_max_in_window > k_limit:
                    if nums[left] == max_val:
                        count_max_in_window -= 1
                    left += 1

                ans += (right - left + 1)
            return ans

        n = len(nums)

        # The total number of subarrays in an array of length n is n * (n + 1) / 2.
        # We want to count subarrays where the maximum element appears at least K times.
        # This is equivalent to:
        # (Total subarrays) - (Subarrays where the maximum element appears at most K-1 times).

        total_subarrays = n * (n + 1) // 2

        subarrays_at_most_k_minus_1 = count_subarrays_with_at_most_k_occurrences(k - 1)

        return total_subarrays - subarrays_at_most_k_minus_1