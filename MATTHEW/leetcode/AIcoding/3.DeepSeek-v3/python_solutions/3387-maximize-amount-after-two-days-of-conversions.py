class Solution:
    def maximumAmount(self, amounts: List[int]) -> int:
        amounts.sort()
        n = len(amounts)
        if n == 1:
            return 0
        elif n == 2:
            return min(amounts)
        else:
            return max(amounts[-2], min(amounts[-1], amounts[-3]))