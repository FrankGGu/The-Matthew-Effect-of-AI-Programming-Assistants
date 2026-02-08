class Solution:
    def bestClosingTime(self, customers: str) -> int:
        n = len(customers)
        prefix_y = [0] * (n + 1)
        for i in range(n):
            prefix_y[i + 1] = prefix_y[i] + (1 if customers[i] == 'Y' else 0)

        min_penalty = float('inf')
        best_time = 0

        for i in range(n + 1):
            penalty = prefix_y[n] - prefix_y[i] + i - prefix_y[i]
            if penalty < min_penalty:
                min_penalty = penalty
                best_time = i

        return best_time