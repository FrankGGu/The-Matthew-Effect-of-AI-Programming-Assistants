class Solution:
    def doesValidArrayExist(self, derived: list[int]) -> bool:
        n = len(derived)
        first = 0
        for i in range(n):
            first ^= derived[i]
        return first == 0