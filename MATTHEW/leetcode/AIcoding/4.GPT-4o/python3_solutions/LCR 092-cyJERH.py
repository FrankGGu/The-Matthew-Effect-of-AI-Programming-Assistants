class Solution:
    def minimumDeletions(self, s: str) -> int:
        count = 0
        max_char = 'a'
        for char in s:
            if char < max_char:
                count += 1
            else:
                max_char = char
        return count