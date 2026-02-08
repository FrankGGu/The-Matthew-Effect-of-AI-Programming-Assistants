class Solution:
    def maximumEvenSplit(self, finalSum: int):
        if finalSum % 2 != 0:
            return []
        return [i for i in range(2, finalSum + 1, 2)]