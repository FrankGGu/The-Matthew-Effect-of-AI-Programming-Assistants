class Solution:
    def longestPalindrome(self, s: str) -> int:
        count = {}
        for char in s:
            count[char] = count.get(char, 0) + 1

        length = 0
        odd_found = False

        for freq in count.values():
            if freq % 2 == 0:
                length += freq
            else:
                length += freq - 1
                odd_found = True

        if odd_found:
            length += 1

        return length