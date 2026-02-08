class Solution:
    def totalMoney(self, n: int) -> int:
        num_weeks = n // 7
        remaining_days = n % 7

        total_money = 0

        # Calculate money from full weeks
        # The sum for the first week is 1+2+3+4+5+6+7 = 28
        # The sum for the second week is 2+3+4+5+6+7+8 = 35 (28 + 7)
        # The sum for the k-th week (1-indexed) is 28 + (k-1)*7
        # This is an arithmetic progression for the sum of weeks: 28, 35, 42, ...
        # Sum of an arithmetic series: S_n = n/2 * (2*a + (n-1)*d)
        # Here, n = num_weeks, a = 28, d = 7
        # S_num_weeks = num_weeks * (2 * 28 + (num_weeks - 1) * 7) // 2
        # S_num_weeks = num_weeks * (56 + 7 * num_weeks - 7) // 2
        # S_num_weeks = num_weeks * (49 + 7 * num_weeks) // 2
        # S_num_weeks = 7 * num_weeks * (7 + num_weeks) // 2
        total_money += 7 * num_weeks * (7 + num_weeks) // 2

        # Calculate money from remaining days
        # The deposits for the partial week start from (num_weeks + 1)
        # The sequence of deposits is:
        # (num_weeks + 1), (num_weeks + 2), ..., (num_weeks + remaining_days)
        # This is also an arithmetic series:
        # count = remaining_days
        # first_term = num_weeks + 1
        # last_term = num_weeks + remaining_days
        # Sum = count/2 * (first_term + last_term)
        # S_remaining = remaining_days * (num_weeks + 1 + num_weeks + remaining_days) // 2
        # S_remaining = remaining_days * (2 * num_weeks + 1 + remaining_days) // 2
        total_money += remaining_days * (2 * num_weeks + 1 + remaining_days) // 2

        return total_money