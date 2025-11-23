import collections

class Solution:
    def minCharacters(self, a: str, b: str) -> int:
        freq_a = [0] * 26
        for char_code in a:
            freq_a[ord(char_code) - ord('a')] += 1

        freq_b = [0] * 26
        for char_code in b:
            freq_b[ord(char_code) - ord('a')] += 1

        ans = float('inf')

        # Condition 1: All characters in 'a' are strictly less than all characters in 'b'.
        # This implies there exists a character 'p' (from 'a' to 'y') such that
        # all characters in 'a' are changed to be <= 'p'
        # and all characters in 'b' are changed to be >= 'p' + 1.
        for p_idx in range(25): # 'p' ranges from 'a' (0) to 'y' (24)
            cost = 0
            # Count changes for string 'a': characters greater than 'p' must be changed.
            for i in range(p_idx + 1, 26):
                cost += freq_a[i]
            # Count changes for string 'b': characters less than or equal to 'p' must be changed.
            for i in range(0, p_idx + 1):
                cost += freq_b[i]
            ans = min(ans, cost)

        # Condition 2: All characters in 'b' are strictly less than all characters in 'a'.
        # This is symmetric to Condition 1.
        for p_idx in range(25): # 'p' ranges from 'a' (0) to 'y' (24)
            cost = 0
            # Count changes for string 'b': characters greater than 'p' must be changed.
            for i in range(p_idx + 1, 26):
                cost += freq_b[i]
            # Count changes for string 'a': characters less than or equal to 'p' must be changed.
            for i in range(0, p_idx + 1):
                cost += freq_a[i]
            ans = min(ans, cost)

        # Condition 3: All characters in both 'a' and 'b' are the same character.
        # Iterate through all possible characters 'k' (from 'a' to 'z').
        for k_idx in range(26):
            # Cost is the number of characters in 'a' not equal to 'k'
            # plus the number of characters in 'b' not equal to 'k'.
            cost = (len(a) - freq_a[k_idx]) + (len(b) - freq_b[k_idx])
            ans = min(ans, cost)

        return ans