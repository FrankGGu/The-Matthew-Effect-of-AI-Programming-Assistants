class Solution:
    def maximumEvenSplit(self, finalSum: int) -> list[int]:
        if finalSum % 2 != 0:
            return []

        result = []
        current = 2
        while finalSum >= current:
            result.append(current)
            finalSum -= current
            current += 2

        if finalSum > 0:
            result[-1] += finalSum

        return result