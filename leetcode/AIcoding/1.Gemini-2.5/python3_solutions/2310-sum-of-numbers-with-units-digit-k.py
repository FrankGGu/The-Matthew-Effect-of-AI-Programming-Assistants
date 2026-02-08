class Solution:
    def minimumNumbers(self, num: int, k: int) -> int:
        if num == 0:
            return 0

        if k == 0:
            if num % 10 == 0:
                return num // 10
            else:
                return -1

        # For k > 0, we need to find the minimum count 'c' such that:
        # 1. c * k <= num
        # 2. (num - c * k) is a non-negative multiple of 10.
        # This means (num - c * k) % 10 == 0.
        #
        # The numbers in the set are of the form (10*a_i + k), where a_i >= 0.
        # The sum of 'c' such numbers is:
        # sum(10*a_i + k) = 10 * sum(a_i) + c * k = num
        # This implies sum(a_i) = (num - c * k) / 10.
        # Since each a_i must be non-negative, sum(a_i) must be non-negative.
        # Thus, (num - c * k) must be non-negative and divisible by 10.
        # If these two conditions are met, we can always construct the set of numbers.
        # (e.g., one number is 10 * ((num - c*k) // 10) + k, and the other c-1 numbers are k).

        # We only need to check 'c' from 1 to 10.
        # If a solution `c_min` exists and `c_min > 10`, then `c' = c_min - 10` would also satisfy
        # the conditions:
        # 1. `c' * k = (c_min - 10) * k = c_min * k - 10 * k`. Since `c_min * k <= num` and `k > 0`,
        #    it follows that `c' * k < c_min * k <= num`. So `c' * k <= num`.
        # 2. `(num - c' * k) = (num - (c_min - 10) * k) = (num - c_min * k) + 10 * k`.
        #    Since `(num - c_min * k)` is divisible by 10, and `10 * k` is divisible by 10,
        #    `(num - c' * k)` is also divisible by 10.
        # This means `c'` would be a valid count, but `c' < c_min`, contradicting `c_min` being minimal.
        # Therefore, if a solution exists, the minimum count must be less than or equal to 10.

        for c in range(1, 11): # Check counts from 1 to 10
            current_sum_of_k_parts = c * k

            if current_sum_of_k_parts > num:
                # If c*k already exceeds num, then any larger count will also exceed num.
                # So, no solution is possible.
                return -1

            remainder = num - current_sum_of_k_parts

            if remainder % 10 == 0:
                # Found a valid count. Since we iterate 'c' upwards, this is the minimum.
                return c

        # If no solution is found after checking counts from 1 to 10
        return -1