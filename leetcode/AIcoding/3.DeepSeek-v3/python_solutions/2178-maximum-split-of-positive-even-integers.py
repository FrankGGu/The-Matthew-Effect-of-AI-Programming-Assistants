class Solution:
    def maximumEvenSplit(self, finalSum: int) -> List[int]:
        if finalSum % 2 != 0:
            return []

        res = []
        current = 2
        remaining = finalSum

        while remaining >= current:
            res.append(current)
            remaining -= current
            current += 2

        if remaining > 0:
            res[-1] += remaining

        return res