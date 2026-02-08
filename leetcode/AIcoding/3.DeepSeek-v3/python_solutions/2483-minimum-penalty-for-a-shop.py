class Solution:
    def bestClosingTime(self, customers: str) -> int:
        n = len(customers)
        penalty = customers.count('Y')
        min_penalty = penalty
        best_hour = 0

        for i in range(1, n + 1):
            if customers[i - 1] == 'Y':
                penalty -= 1
            else:
                penalty += 1

            if penalty < min_penalty:
                min_penalty = penalty
                best_hour = i

        return best_hour