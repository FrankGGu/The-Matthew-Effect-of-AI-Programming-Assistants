class Solution:
    def chalkReplacer(self, chalk: list[int], k: int) -> int:
        total_chalk_per_cycle = sum(chalk)

        k %= total_chalk_per_cycle

        for i in range(len(chalk)):
            if k < chalk[i]:
                return i
            k -= chalk[i]

        return -1 # Should not be reached given problem constraints and logic