from typing import List

class Solution:
    def maxSumRangeQuery(self, nums: List[int], requests: List[List[int]]) -> int:
        n = len(nums)
        MOD = 10**9 + 7

        # Step 1: Count the frequency of each index being requested
        # Use a difference array (prefix sum array for counts)
        counts = [0] * n
        for start, end in requests:
            counts[start] += 1
            if end + 1 < n:
                counts[end + 1] -= 1

        # Step 2: Convert the difference array into actual frequencies
        # by computing prefix sums
        for i in range(1, n):
            counts[i] += counts[i - 1]

        # Step 3: Sort the nums array in descending order
        nums.sort(reverse=True)

        # Step 4: Sort the counts (frequencies) array in descending order
        counts.sort(reverse=True)

        # Step 5: Calculate the maximum sum
        # Multiply the largest numbers from nums with the highest frequencies
        max_sum = 0
        for i in range(n):
            max_sum = (max_sum + nums[i] * counts[i]) % MOD

        return max_sum