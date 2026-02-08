class Solution:
    def bestClosingTime(self, customers: str) -> int:
        penalty = 0
        min_penalty = float('inf')
        best_time = 0

        for i in range(len(customers)):
            if customers[i] == 'Y':
                penalty += 1
            else:
                penalty -= 1

            if penalty < min_penalty:
                min_penalty = penalty
                best_time = i + 1

        return best_time