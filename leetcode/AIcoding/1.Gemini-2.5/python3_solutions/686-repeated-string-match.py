class Solution:
    def repeatedStringMatch(self, a: str, b: str) -> int:
        temp_a = a
        count = 1

        while len(temp_a) < len(b):
            temp_a += a
            count += 1

        if b in temp_a:
            return count

        temp_a += a
        count += 1

        if b in temp_a:
            return count

        return -1