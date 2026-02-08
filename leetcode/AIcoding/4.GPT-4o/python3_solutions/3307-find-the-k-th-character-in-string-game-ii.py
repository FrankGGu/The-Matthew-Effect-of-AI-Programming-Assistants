class Solution:
    def findKthCharacter(self, s: str, k: int) -> str:
        n = len(s)
        total_length = 0
        power = 1

        while total_length + power < k:
            total_length += power
            power *= 2

        k -= total_length
        index = (k - 1) % n

        return s[index]