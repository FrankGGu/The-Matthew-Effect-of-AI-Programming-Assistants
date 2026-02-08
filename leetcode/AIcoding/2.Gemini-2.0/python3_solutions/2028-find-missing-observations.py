class Solution:
    def missingRolls(self, rolls: list[int], mean: int, n: int) -> list[int]:
        m = len(rolls)
        total_sum = mean * (n + m)
        rolls_sum = sum(rolls)
        missing_sum = total_sum - rolls_sum
        if missing_sum < n or missing_sum > 6 * n:
            return []

        base = missing_sum // n
        remainder = missing_sum % n

        result = [base] * n
        for i in range(remainder):
            result[i] += 1

        return result