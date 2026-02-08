class Solution:
    def maxStrength(self, nums: list[int]) -> int:
        pos = []
        neg = []
        has_zero = False

        for n in nums:
            if n > 0:
                pos.append(n)
            elif n < 0:
                neg.append(n)
            else:
                has_zero = True

        # Case 1: All numbers are zeroes
        # If there are no positive numbers and no negative numbers,
        # then all numbers in 'nums' must be zeroes.
        # The maximum strength is 0 (by picking any single zero).
        if not pos and not neg:
            return 0

        # Case 2: Only one negative number (and possibly zeroes), no positive numbers
        # E.g., nums = [-5] or nums = [-5, 0, 0]
        if not pos and len(neg) == 1:
            if has_zero:
                # If there's a zero, picking it gives strength 0,
                # which is greater than the single negative number.
                # E.g., [-5, 0] -> 0
                return 0
            else:
                # If no zero, the only option is the single negative number.
                # E.g., [-5] -> -5
                return neg[0]

        # All other cases: We can always form a positive product (or use 0 if it's the best option)
        # This includes scenarios where:
        # - There is at least one positive number.
        # - There are at least two negative numbers.
        # In these scenarios, we can always achieve a positive product,
        # which will be greater than 0 or any single negative number.

        current_strength = 1

        # Multiply all positive numbers
        for p in pos:
            current_strength *= p

        # Handle negative numbers
        if len(neg) % 2 == 0:
            # If there's an even number of negatives, multiply all of them
            # as their product will be positive.
            for n in neg:
                current_strength *= n
        else:
            # If there's an odd number of negatives, we need to exclude one
            # to make the product positive. To maximize the positive product,
            # we exclude the negative number closest to zero (i.e., the largest negative).
            # Sorting 'neg' helps find the largest negative easily (it will be neg[-1]).
            neg.sort()
            for i in range(len(neg) - 1): # Exclude the largest negative (neg[-1])
                current_strength *= neg[i]

        return current_strength