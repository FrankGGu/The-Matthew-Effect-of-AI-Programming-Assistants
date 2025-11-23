from collections import defaultdict

class Solution:
    def countGoodSubarrays(self, nums: list[int], k: int) -> int:
        def count_subarrays_with_at_most_k_pairs(k_val: int) -> int:
            if k_val < 0:
                return 0

            ans = 0
            left = 0
            current_pairs = 0
            freq = defaultdict(int)

            for right in range(len(nums)):
                # Add nums[right] to the window
                current_pairs += freq[nums[right]]
                freq[nums[right]] += 1

                # Shrink the window from the left if current_pairs exceeds k_val
                while current_pairs > k_val:
                    freq[nums[left]] -= 1
                    current_pairs -= freq[nums[left]]
                    left += 1

                # All subarrays ending at 'right' and starting from 'left' up to 'right' are valid
                ans += (right - left + 1)

            return ans

        # The number of subarrays with exactly k pairs is
        # (number of subarrays with at most k pairs) - (number of subarrays with at most k-1 pairs)
        return count_subarrays_with_at_most_k_pairs(k) - count_subarrays_with_at_most_k_pairs(k - 1)