class Solution:
    def beautifulPartitions(self, s: str, k: int, minLength: int) -> int:
        n = len(s)
        MOD = 10**9 + 7

        primes = {'2', '3', '5', '7'}

        def is_prime_digit(char_digit: str) -> bool:
            return char_digit in primes

        # Pre-check: The first character of the entire string must be prime
        # and the last character must be non-prime for any valid partition to exist.
        if not is_prime_digit(s[0]) or is_prime_digit(s[n - 1]):
            return 0

        # dp[j][i] will store the number of ways to partition the prefix s[0...i-1]
        # into j beautiful partitions.
        # i represents the length of the prefix.
        dp = [[0] * (n + 1) for _ in range(k + 1)]

        # Base case: 0 partitions for an empty prefix (length 0)
        dp[0][0] = 1

        # Iterate through the number of partitions from 1 to k
        for j in range(1, k + 1):
            # current_sum_for_prev_j accumulates dp[j-1][p_len] values
            # where s[p_len] (the character at index p_len in string s) is a prime digit.
            # p_len here represents the starting index of the current (j-th) partition,
            # and also the length of the prefix s[0...p_len-1] for the (j-1) partitions.
            current_sum_for_prev_j = 0

            # Iterate through the possible end points (i-1) of the current (j-th) partition.
            # i represents the length of the prefix s[0...i-1].
            for i in range(1, n + 1):
                # Calculate the potential starting index (p_len) for the current (j-th) partition.
                # The length of the current partition s[p_len ... i-1] must be at least minLength.
                # So, (i-1) - p_len + 1 >= minLength  =>  i - p_len >= minLength  =>  p_len <= i - minLength.
                # The largest possible p_len is i - minLength.
                # When i increments, the window for p_len slides.
                # We need to add dp[j-1][p_len] for the new p_len that enters the window.
                # The new p_len entering the window is exactly `i - minLength`.
                p_len = i - minLength

                # If p_len is a valid starting index (non-negative) and
                # the character at s[p_len] is a prime digit,
                # then add dp[j-1][p_len] to current_sum_for_prev_j.
                # dp[j-1][p_len] is 0 if p_len is too small for j-1 partitions.
                if p_len >= 0:
                    if is_prime_digit(s[p_len]):
                        current_sum_for_prev_j = (current_sum_for_prev_j + dp[j-1][p_len]) % MOD

                # If the current character s[i-1] (end of the j-th partition) is a non-prime digit,
                # then we can form a beautiful partition ending at s[i-1].
                if not is_prime_digit(s[i-1]):
                    # The number of ways to form j partitions ending at s[i-1]
                    # is the sum of ways to form j-1 partitions ending at s[p_len-1]
                    # such that s[p_len...i-1] is a beautiful partition.
                    # This sum is exactly what current_sum_for_prev_j holds.
                    dp[j][i] = current_sum_for_prev_j

        return dp[k][n]