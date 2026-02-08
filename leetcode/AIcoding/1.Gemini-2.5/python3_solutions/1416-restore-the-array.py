class Solution:
    def numberOfArrays(self, s: str, k: int) -> int:
        n = len(s)
        MOD = 10**9 + 7

        dp = [0] * (n + 1)
        dp[n] = 1  # Base case: one way to restore an empty string (empty array)

        # Pre-calculate the maximum number of digits K can have.
        # This helps optimize the inner loop by breaking early.
        max_len_k = len(str(k))

        # Iterate from right to left, considering suffixes s[i:]
        for i in range(n - 1, -1, -1):
            # If the current digit is '0', no number can start with '0',
            # so there are 0 ways to form valid numbers from this position.
            if s[i] == '0':
                dp[i] = 0
                continue

            current_num = 0
            # Iterate from the current position 'i' to 'j' to form numbers s[i:j+1]
            for j in range(i, n):
                num_digits = j - i + 1

                # Optimization: If the number of digits in the current number
                # exceeds the number of digits in k, then current_num must be greater than k.
                # We can break early as any further number formed by adding more digits
                # will also be greater than k.
                if num_digits > max_len_k:
                    break

                # Build the current number digit by digit
                current_num = current_num * 10 + int(s[j])

                # If current_num exceeds k, then it's an invalid number.
                # Any further number formed by adding more digits will also exceed k,
                # so we can break.
                if current_num > k:
                    break

                # If current_num is a valid number, add the number of ways
                # to restore the rest of the array from the suffix s[j+1:]
                dp[i] = (dp[i] + dp[j+1]) % MOD

        # The result is the number of ways to restore the array from the entire string s[0:]
        return dp[0]