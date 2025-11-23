class Solution:
    def goodDaysToRobBank(self, security: list[int], time: int) -> list[int]:
        n = len(security)

        if time == 0:
            return list(range(n))

        if n < 2 * time + 1:
            return []

        left_non_increasing = [1] * n
        for i in range(1, n):
            if security[i] <= security[i - 1]:
                left_non_increasing[i] = left_non_increasing[i - 1] + 1
            else:
                left_non_increasing[i] = 1

        right_non_decreasing = [1] * n
        for i in range(n - 2, -1, -1):
            if security[i] <= security[i + 1]:
                right_non_decreasing[i] = right_non_decreasing[i + 1] + 1
            else:
                right_non_decreasing[i] = 1

        result = []
        for i in range(time, n - time):
            if left_non_increasing[i] >= time + 1 and right_non_decreasing[i] >= time + 1:
                result.append(i)

        return result