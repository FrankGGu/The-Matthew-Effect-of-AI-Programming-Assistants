class Solution:
    def shortestPalindrome(self, s: str) -> str:
        n = len(s)
        if n == 0:
            return ""

        s_rev = s[::-1]

        # Construct the KMP string to find the longest palindromic prefix.
        # The string is s + "#" + s_reversed.
        # The LPS (Longest Proper Prefix which is also Suffix) array for this string
        # will have its last element indicating the length of the longest prefix of 's'
        # that is also a suffix of 's_reversed'. This length corresponds to the
        # longest palindromic prefix of 's'.

        text = s + "#" + s_rev
        m = len(text)

        pi = [0] * m  # LPS array
        j = 0  # length of the previous longest prefix suffix

        for i in range(1, m):
            while j > 0 and text[i] != text[j]:
                j = pi[j-1]
            if text[i] == text[j]:
                j += 1
            pi[i] = j

        # The length of the longest palindromic prefix of s is pi[m-1].
        longest_palindromic_prefix_len = pi[m-1]

        # The characters to prepend are the reverse of the suffix of s
        # that comes after the longest palindromic prefix.
        # If s = (longest_palindromic_prefix) + (remaining_suffix),
        # then the result is (remaining_suffix_reversed) + s.

        # The remaining_suffix is s[longest_palindromic_prefix_len:].
        # Its reversed form is equivalent to the prefix of s_rev
        # with length (n - longest_palindromic_prefix_len).

        return s_rev[:n - longest_palindromic_prefix_len] + s