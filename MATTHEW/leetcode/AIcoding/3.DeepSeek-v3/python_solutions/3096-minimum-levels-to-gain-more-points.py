class Solution:
    def minimumLevels(self, possible: List[int]) -> int:
        n = len(possible)
        total = sum(1 if x == 1 else -1 for x in possible)
        current = 0

        for i in range(n - 1):
            current += 1 if possible[i] == 1 else -1
            if current > total - current:
                return i + 1

        return -1