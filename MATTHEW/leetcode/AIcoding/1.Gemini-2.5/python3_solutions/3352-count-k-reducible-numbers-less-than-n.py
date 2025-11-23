class Solution:
    def countKReducibleNumbers(self, N: int, K: int) -> int:
        # The problem asks for numbers strictly less than N.
        # This means we need to count numbers from 1 up to N-1.
        # We will use digit DP to count numbers from 0 up to N-1 (inclusive)
        # that satisfy the "K-Reducible" property, then adjust if 0 is counted and shouldn't be.

        # Convert N-1 to a string to iterate through its digits.
        # If N=1, N-1=0, so target_num_str will be "0".
        target_num_str = str(N - 1)
        n = len(target_num_str)

        # Memoization table: memo[index][current_sum_mod_K][tight][is_started]
        # index: current digit position we are considering (from 0 to n-1)
        # current_sum_mod_K: the current sum of digits modulo K
        # tight: boolean, true if we are still restricted by the digits of target_num_str
        # is_started: boolean, true if we have placed at least one non-zero digit, indicating a valid number has begun
        memo = {}

        def dp(index: int, current_sum_mod_K: int, tight: bool, is_started: bool) -> int:
            # Base case: If we have processed all digits.
            if index == n:
                # A number is valid if its sum of digits is divisible by K AND
                # it's a non-empty number (i.e., we've placed at least one non-zero digit, or it was the number 0 itself).
                # The 'is_started' flag becomes True once a non-zero digit is placed.
                # If 'is_started' is False, it means we only placed leading zeros (e.g., "007"), which is not a valid number
                # unless the number itself is '0'.
                # For this interpretation (sum of digits divisible by K), the number 0 has sum of digits 0, which is divisible by any K >= 1.
                # However, typically, "count numbers" problems imply positive integers.
                # Our `is_started` logic ensures that the number 0 is NOT counted.
                # Example: for N=1, target_num_str="0". dp(0,0,True,False) -> digit=0 -> dp(1,0,True,False).
                # At index=1 (base case), current_sum_mod_K=0, is_started=False. Returns 0. Correct.
                return 1 if current_sum_mod_K == 0 and is_started else 0

            state = (index, current_sum_mod_K, tight, is_started)
            if state in memo:
                return memo[state]

            ans = 0
            # Determine the upper bound for the current digit.
            # If 'tight' is True, we cannot exceed the digit in target_num_str[index].
            # Otherwise, we can go up to 9.
            upper_bound = int(target_num_str[index]) if tight else 9

            for digit in range(upper_bound + 1):
                if is_started or digit > 0:
                    # If we have already started forming a non-zero number (is_started is True),
                    # or if the current digit we are placing is non-zero (starting a new number).
                    # In this case, 'is_started' becomes True for the next recursive call.
                    ans += dp(index + 1, (current_sum_mod_K + digit) % K, tight and (digit == upper_bound), True)
                else:
                    # This branch is for placing leading zeros.
                    # 'is_started' is False, and the current digit is 0.
                    # The sum_mod_K remains 0, and 'is_started' remains False for the next call.
                    ans += dp(index + 1, 0, tight and (digit == upper_bound), False)

            memo[state] = ans
            return ans

        # Initial call to the DP function:
        # - Start at index 0.
        # - Initial sum of digits modulo K is 0.
        # - Tight constraint is True (we are restricted by N-1).
        # - is_started is False (we haven't placed any non-zero digits yet).
        result = dp(0, 0, True, False)

        # The result correctly counts positive numbers from 1 to N-1
        # whose sum of digits is divisible by K.
        return result