class Solution:
    def maxSatisfied(self, customers: List[int], grumpy: List[int], minutes: int) -> int:
        n = len(customers)
        satisfied = 0
        max_extra = 0
        current_extra = 0

        for i in range(n):
            if grumpy[i] == 0:
                satisfied += customers[i]
            else:
                current_extra += customers[i]
            if i >= minutes and grumpy[i - minutes] == 1:
                current_extra -= customers[i - minutes]
            if current_extra > max_extra:
                max_extra = current_extra

        return satisfied + max_extra