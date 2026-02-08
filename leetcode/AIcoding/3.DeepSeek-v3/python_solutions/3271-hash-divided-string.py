class Solution:
    def hashDividedString(self, s: str) -> bool:
        n = len(s)
        if n % 2 != 0:
            return False
        first_hash = 0
        second_hash = 0
        half = n // 2
        for i in range(half):
            first_hash += ord(s[i])
            second_hash += ord(s[i + half])
        return first_hash == second_hash