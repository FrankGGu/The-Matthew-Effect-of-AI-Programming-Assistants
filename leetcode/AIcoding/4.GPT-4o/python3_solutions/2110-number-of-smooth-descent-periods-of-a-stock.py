class Solution:
    def getDescentPeriods(self, prices: List[int]) -> int:
        count = 0
        current = 1

        for i in range(1, len(prices)):
            if prices[i] == prices[i - 1] - 1:
                current += 1
            else:
                current = 1
            count += current

        return count + 1