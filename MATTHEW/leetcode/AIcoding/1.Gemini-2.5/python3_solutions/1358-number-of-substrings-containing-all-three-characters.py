class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        n = len(s)
        count = 0
        left = 0
        # freq[0] for 'a', freq[1] for 'b', freq[2] for 'c'
        freq = [0, 0, 0] 

        for right in range(n):
            # Add character at right to the window
            freq[ord(s[right]) - ord('a')] += 1

            # While the current window contains at least one 'a', 'b', and 'c'
            while freq[0] > 0 and freq[1] > 0 and freq[2] > 0:
                # If s[left...right] is a valid substring, then any substring
                # starting at 'left' and ending at 'right' or any point further
                # to the right (up to n-1) will also be valid.
                # The number of such substrings is (n - 1) - right + 1 = n - right.
                count += (n - right)

                # Shrink the window from the left by removing s[left]
                freq[ord(s[left]) - ord('a')] -= 1
                left += 1

        return count