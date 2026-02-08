class Solution:
    def minPenalty(self, customers: str) -> int:
        n = len(customers)

        current_penalty = 0
        for char in customers:
            if char == 'Y':
                current_penalty += 1

        min_penalty = current_penalty
        best_j = 0

        for i in range(n):
            if customers[i] == 'Y':
                current_penalty -= 1
            else: # customers[i] == 'N'
                current_penalty += 1

            if current_penalty < min_penalty:
                min_penalty = current_penalty
                best_j = i + 1

        return best_j