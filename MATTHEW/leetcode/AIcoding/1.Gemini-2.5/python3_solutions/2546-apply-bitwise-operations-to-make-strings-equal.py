class Solution:
    def makeStringsEqual(self, s: str, target: str) -> bool:
        s_ones = s.count('1')
        target_ones = target.count('1')
        n = len(s)

        # If both strings are all '0's, they are already equal.
        if s_ones == 0 and target_ones == 0:
            return True

        # If one string is all '0's and the other has '1's:
        # We need to be able to create '1's from '0's or remove '1's to get '0's.
        # This is possible if and only if the parity of '1's matches.
        # (e.g., "00" -> "11" is possible because 0%2 == 2%2. "0" -> "1" is not possible because 0%2 != 1%2).
        # The operations always change the count of '1's by an even number.
        # So, if s_ones is 0, target_ones must be even.
        # If target_ones is 0, s_ones must be even.
        if s_ones == 0 or target_ones == 0:
            return (s_ones % 2) == (target_ones % 2)

        # If both strings have at least one '1':
        # Now, s_ones > 0 and target_ones > 0.

        # First, check the parity condition, which is always necessary.
        if (s_ones % 2) != (target_ones % 2):
            return False

        # If parities match, in most cases, it's possible.
        # The only exception is when the string is "stuck" and cannot perform any operation.
        # A string is "stuck" if it has exactly one '1' and exactly one '0' (i.e., n=2 and s_ones=1).
        # In this specific scenario, if s is "01" or "10", no operations can be performed.
        # If target is also "01" or "10", and s != target, then it's impossible.
        # Since s_ones > 0 and target_ones > 0 and parities match, if s_ones == 1, then target_ones must also be 1.
        # So, if n == 2 and s_ones == 1 (meaning s is "01" or "10"):
        #     Then target must also be "01" or "10" (because target_ones is also 1).
        #     In this case, s can only be transformed to target if s is identical to target.
        if n == 2 and s_ones == 1:
            return s == target

        # In all other cases where both strings have at least one '1' and parities match,
        # it's always possible to transform s to target.
        # This is because we can always find two '1's to turn into '0's, or two '0's to turn into '1's,
        # or use a combination to reach a state where such operations are possible.
        return True