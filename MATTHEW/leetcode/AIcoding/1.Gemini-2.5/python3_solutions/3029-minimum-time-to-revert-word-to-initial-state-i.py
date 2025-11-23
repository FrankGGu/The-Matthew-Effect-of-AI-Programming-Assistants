import math

class Solution:
    def minimumTimeToRevert(self, word: str, k: int) -> int:
        n = len(word)

        # Step 1: Compute the KMP pi (LPS - Longest Proper Prefix which is also Suffix) array.
        # pi[i] stores the length of the longest proper prefix of word[0...i]
        # that is also a suffix of word[0...i].
        pi = [0] * n
        j = 0  # length of the previous longest prefix suffix
        for i in range(1, n):
            while j > 0 and word[i] != word[j]:
                j = pi[j - 1]
            if word[i] == word[j]:
                j += 1
            pi[i] = j

        # Step 2: Determine the smallest cyclic period (P_0) of the word.
        # The smallest period of a string 's' of length 'n' is 'n - pi[n-1]'
        # if 'n' is divisible by 'n - pi[n-1]'. Otherwise, the smallest period is 'n'.
        # This is a standard result from KMP algorithm.
        lps = pi[n - 1]
        if lps == 0 or n % (n - lps) != 0:
            P_0 = n
        else:
            P_0 = n - lps

        # Step 3: Calculate the minimum time 't'.
        # An operation rotates the word left by 'k' characters.
        # We need to find the minimum 't >= 1' such that after 't' operations,
        # the word returns to its initial state.
        # This means the total rotation amount (t * k) must be a multiple of the
        # smallest cyclic period P_0 of the word.
        # We are looking for the smallest positive integer 't' such that (t * k) is a multiple of P_0.
        # This can be found using the formula: t = P_0 / gcd(k, P_0).

        return P_0 // math.gcd(k, P_0)