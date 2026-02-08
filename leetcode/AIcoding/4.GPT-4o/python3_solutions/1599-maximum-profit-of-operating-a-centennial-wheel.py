class Solution:
    def minOperationsMaxProfit(self, A: List[int], B: int) -> int:
        max_profit = 0
        current_profit = 0
        max_operations = -1
        operations = 0

        for i in range(len(A)):
            operations += A[i]
            current_profit += A[i] * B

            if operations > 0:
                profit_per_operation = current_profit // operations
                if profit_per_operation > max_profit:
                    max_profit = profit_per_operation
                    max_operations = operations

                current_profit -= operations * B
                operations = 0

        return max_operations if max_operations != -1 else 0