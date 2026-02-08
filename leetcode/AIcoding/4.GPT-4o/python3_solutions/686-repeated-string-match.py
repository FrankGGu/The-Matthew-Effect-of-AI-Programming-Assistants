class Solution:
    def repeatedStringMatch(self, a: str, b: str) -> int:
        count = 1
        repeated_a = a

        while len(repeated_a) < len(b):
            repeated_a += a
            count += 1

        if b in repeated_a:
            return count

        repeated_a += a
        if b in repeated_a:
            return count + 1

        return -1