class Solution:
    def maxSatisfied(self, customers: List[int], grumpy: List[int], X: int) -> int:
        total_satisfied = sum(customers[i] for i in range(len(customers)) if grumpy[i] == 0)
        additional_satisfied = sum(customers[i] for i in range(X) if grumpy[i] == 1)
        max_additional = additional_satisfied

        for i in range(X, len(customers)):
            additional_satisfied += customers[i] * (grumpy[i] == 1)
            additional_satisfied -= customers[i - X] * (grumpy[i - X] == 1)
            max_additional = max(max_additional, additional_satisfied)

        return total_satisfied + max_additional