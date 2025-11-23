from collections import defaultdict

class Solution:
    def countInterestingSubarrays(self, nums: list[int], modulo: int, k: int) -> int:
        prefix_freq = defaultdict(int)
        prefix_freq[0] = 1  # Base case: an empty prefix has sum 0, and it occurs once.

        curr_sum = 0
        ans = 0

        for num in nums:
            # Transform the problem: create a binary array where 1 means num % modulo == k
            if num % modulo == k:
                curr_sum += 1

            # We are looking for a previous prefix sum 'P' such that 'curr_sum - P == k'.
            # This means 'P = curr_sum - k'.
            # If such a 'P' exists, then the subarray from the end of P to the current element
            # has a sum of 'k'.
            if (curr_sum - k) in prefix_freq:
                ans += prefix_freq[curr_sum - k]

            # Increment the frequency of the current prefix sum
            prefix_freq[curr_sum] += 1

        return ans