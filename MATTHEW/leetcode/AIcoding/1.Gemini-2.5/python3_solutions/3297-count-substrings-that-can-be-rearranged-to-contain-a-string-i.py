class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        ans = 0
        left = 0
        freq = {'a': 0, 'b': 0, 'c': 0}

        for right in range(len(s)):
            freq[s[right]] += 1

            while freq['a'] > 0 and freq['b'] > 0 and freq['c'] > 0:
                # If the current window s[left...right] contains 'a', 'b', and 'c',
                # then any substring starting from an index k (where k <= left)
                # and ending at 'right' will also contain 'a', 'b', and 'c'.
                # The number of such starting positions is (left - 0 + 1) = left + 1.
                ans += (left + 1)

                # Shrink the window from the left to find the next smallest valid window
                # or to make the current window invalid, which will terminate the while loop.
                freq[s[left]] -= 1
                left += 1

        return ans