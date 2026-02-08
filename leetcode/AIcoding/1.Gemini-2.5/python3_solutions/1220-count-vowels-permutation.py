class Solution:
    def countVowelPermutation(self, n: int) -> int:
        MOD = 10**9 + 7

        # Initialize counts for strings of length 1
        # dp_a, dp_e, dp_i, dp_o, dp_u represent the number of valid strings
        # of the current length ending with 'a', 'e', 'i', 'o', 'u' respectively.
        prev_a = 1
        prev_e = 1
        prev_i = 1
        prev_o = 1
        prev_u = 1

        # Iterate from length 2 up to n
        for _ in range(2, n + 1):
            # Calculate counts for the current length based on the previous length's counts
            # Rules:
            # 'a' can only be followed by 'e'.
            # 'e' can only be followed by 'a' or 'i'.
            # 'i' can not be followed by another 'i'. (Can be followed by 'a', 'e', 'o', 'u')
            # 'o' can only be followed by 'i' or 'u'.
            # 'u' can only be followed by 'a'.

            # If a string ends with 'a', the previous vowel must have been 'e', 'i', or 'u'.
            curr_a = (prev_e + prev_i + prev_u) % MOD
            # If a string ends with 'e', the previous vowel must have been 'a' or 'i'.
            curr_e = (prev_a + prev_i) % MOD
            # If a string ends with 'i', the previous vowel must have been 'e' or 'o'.
            curr_i = (prev_e + prev_o) % MOD
            # If a string ends with 'o', the previous vowel must have been 'i'.
            curr_o = (prev_i) % MOD
            # If a string ends with 'u', the previous vowel must have been 'i' or 'o'.
            curr_u = (prev_i + prev_o) % MOD

            # Update the 'previous' counts for the next iteration
            prev_a = curr_a
            prev_e = curr_e
            prev_i = curr_i
            prev_o = curr_o
            prev_u = curr_u

        # The total number of valid strings of length n is the sum of all counts
        # for strings of length n ending with any vowel.
        return (prev_a + prev_e + prev_i + prev_o + prev_u) % MOD