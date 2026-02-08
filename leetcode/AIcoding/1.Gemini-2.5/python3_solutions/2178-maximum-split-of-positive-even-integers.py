class Solution:
    def maximumEvenSplit(self, finalSum: int) -> list[int]:
        if finalSum % 2 != 0:
            return []

        result = []
        current_sum = 0
        num = 2

        while current_sum + num <= finalSum:
            result.append(num)
            current_sum += num
            num += 2

        if result:
            remaining_sum = finalSum - current_sum
            result[-1] += remaining_sum

        return result