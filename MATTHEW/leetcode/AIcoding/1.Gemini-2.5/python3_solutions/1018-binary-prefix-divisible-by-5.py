class Solution:
    def prefixesDivBy5(self, A: list[int]) -> list[bool]:
        result = []
        current_remainder = 0
        for bit in A:
            current_remainder = (current_remainder * 2 + bit) % 5
            result.append(current_remainder == 0)
        return result