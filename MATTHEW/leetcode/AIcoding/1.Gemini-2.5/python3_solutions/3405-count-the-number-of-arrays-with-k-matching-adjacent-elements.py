class Solution:
    def countArrays(self, n: int, m: int, k: int) -> int:
        MOD = 10**9 + 7

        # dp[j] will store the number of arrays of current length 'i'
        # with 'j' matching adjacent elements, where the last element is fixed to some specific value (e.g., 1).
        # We use space optimization, so we only need to store the previous row's values.

        # prev_dp represents dp[i-1] for the number of matches
        # curr_dp represents dp[i] for the number of matches

        # Initialize for length 1 (i=1)
        # An array of length 1 has 0 matching adjacent elements.
        # There is 1 way to form such an array if the last element is fixed (e.g., [1]).
        prev_dp = [0] * (k + 1)
        prev_dp[0] = 1 

        # Iterate for array length from 2 to n
        for i in range(2, n + 1):
            curr_dp = [0] * (k + 1)
            # Iterate for number of matching adjacent elements from 0 to k
            for j in range(k + 1):
                # Case 1: The current element arr[i] is the same as arr[i-1].
                # This adds one matching pair. So, we need j-1 matches from the first i-1 elements.
                # The (i-1)-th element must be the same fixed value.
                if j > 0:
                    curr_dp[j] = (curr_dp[j] + prev_dp[j - 1]) % MOD

                # Case 2: The current element arr[i] is different from arr[i-1].
                # This does not add a matching pair. So, we need j matches from the first i-1 elements.
                # The (i-1)-th element can be any of the (m-1) values different from the fixed last element.
                # By symmetry, each of these (m-1) choices contributes prev_dp[j] ways.
                curr_dp[j] = (curr_dp[j] + (m - 1) * prev_dp[j]) % MOD

            prev_dp = curr_dp

        # The final answer is the sum of ways for all possible last elements.
        # Since prev_dp[k] (which is dp[n][k]) counts arrays ending with a specific value,
        # and there are 'm' such specific values, we multiply by 'm'.
        return (m * prev_dp[k]) % MOD