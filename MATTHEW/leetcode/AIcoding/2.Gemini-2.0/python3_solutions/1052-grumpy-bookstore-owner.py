class Solution:
    def maxSatisfied(self, customers: List[int], grumpy: List[int], X: int) -> int:
        n = len(customers)
        max_gain = 0
        current_gain = 0
        for i in range(X):
            if grumpy[i] == 1:
                current_gain += customers[i]
        max_gain = current_gain

        for i in range(X, n):
            if grumpy[i] == 1:
                current_gain += customers[i]
            if grumpy[i - X] == 1:
                current_gain -= customers[i - X]
            max_gain = max(max_gain, current_gain)

        satisfied = 0
        for i in range(n):
            if grumpy[i] == 0:
                satisfied += customers[i]

        return satisfied + max_gain