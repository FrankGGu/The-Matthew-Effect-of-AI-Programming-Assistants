class Solution:
    def numDupDigitsAtMostN(self, n: int) -> int:

        # Helper function to calculate permutations P(n, k)
        # P(n, k) = n * (n-1) * ... * (n-k+1)
        def A(n, k):
            if k < 0 or k > n:
                return 0
            res = 1
            for _ in range(k):
                res *= n
                n -= 1
            return res

        s = str(n)
        L = len(s)
        N_digits = [int(d) for d in s]

        # Step 1: Count numbers with unique digits that have length less than L
        # For k-digit numbers (1 <= k < L):
        # The first digit can be chosen in 9 ways (1-9).
        # The remaining k-1 digits can be chosen from the remaining 9 digits (0-9 excluding the first) in P(9, k-1) ways.
        count_unique_less_than_L_digits = 0
        for k in range(1, L):
            count_unique_less_than_L_digits += 9 * A(9, k - 1)

        # Step 2: Count numbers with unique digits that have exactly L digits and are <= N
        count_unique_L_digits = 0
        seen = set() # To keep track of digits used in the current prefix

        for i in range(L):
            d_i = N_digits[i] # Current digit of N

            # Iterate through possible digits 'j' for the current position 'i'
            # 'j' must be less than d_i
            # 'j' cannot be 0 if it's the first digit (i=0)
            start_j = 1 if i == 0 else 0
            for j in range(start_j, d_i):
                if j not in seen:
                    # If 'j' is chosen, we have (L - 1 - i) remaining positions
                    # And (10 - len(seen) - 1) available digits (10 total - digits in seen - 'j')
                    count_unique_L_digits += A(10 - len(seen) - 1, L - 1 - i)

            # After trying digits 'j' smaller than d_i,
            # we consider d_i itself.
            # If d_i is already in 'seen', it means N itself has repeated digits up to this point.
            # So, no more unique-digit numbers can be formed with this prefix, break.
            if d_i in seen:
                break

            seen.add(d_i) # Add d_i to seen for the next iteration

            # If we are at the last digit (i == L-1) and haven't broken,
            # it means N itself has unique digits.
            if i == L - 1:
                count_unique_L_digits += 1

        # Total numbers with unique digits up to N
        total_unique_digits = count_unique_less_than_L_digits + count_unique_L_digits

        # The result is N minus the count of numbers with unique digits.
        return n - total_unique_digits