import collections

class Solution:
    def countSubMultisets(self, nums: list[int], l: int, r: int) -> int:
        MOD = 10**9 + 7

        counts = collections.Counter(nums)

        dp = [0] * (r + 1)

        # Base case: one way to achieve sum 0 (empty multiset)
        # This will be adjusted if 0s are present in nums.
        dp[0] = 1

        # Handle 0s separately
        if 0 in counts:
            freq_0 = counts[0]
            del counts[0]
            # If we have freq_0 zeros, we can choose 0, 1, ..., freq_0 zeros.
            # This means there are (freq_0 + 1) ways to form sum 0 using only zeros.
            # The initial dp[0] = 1 represents the empty set.
            # If 0s are available, dp[0] should reflect all ways to make sum 0 using only zeros.
            dp[0] = freq_0 + 1

        # Iterate through each unique number (num > 0) and its frequency
        for num, freq in counts.items():
            # Create a copy of dp to use values from the previous iteration
            # before processing the current 'num'.
            prev_dp = list(dp) 

            # Iterate through possible starting sums modulo 'num'
            # This groups sums that are congruent modulo 'num'
            for start_s in range(num):
                current_window_sum = 0

                # Iterate through sums 's' in steps of 'num'
                # s = start_s + j * num
                for j in range((r - start_s) // num + 1):
                    s = start_s + j * num

                    # Add the count from the previous state (without current 'num')
                    # to the sliding window sum.
                    current_window_sum = (current_window_sum + prev_dp[s]) % MOD

                    # If the window size exceeds 'freq', remove the oldest element
                    # The window represents choosing k copies of 'num', where 0 <= k <= freq.
                    # This means we sum prev_dp[s - k*num] for k from 0 to freq.
                    # The window effectively has size (freq + 1).
                    # If j > freq, it means we are considering s = start_s + j*num.
                    # The oldest element to remove is prev_dp[start_s + (j - (freq + 1))*num]
                    # which is prev_dp[s_to_remove] where s_to_remove = start_s + (j - freq - 1)*num.
                    if j > freq:
                        s_to_remove = start_s + (j - freq - 1) * num
                        current_window_sum = (current_window_sum - prev_dp[s_to_remove] + MOD) % MOD

                    # Update dp[s] with the current sliding window sum
                    dp[s] = current_window_sum

        # Sum up all valid counts within the range [l, r]
        ans = 0
        for s in range(l, r + 1):
            ans = (ans + dp[s]) % MOD

        return ans