class Solution:
    def oddEvenTransactions(self, transactions: List[int]) -> int:
        count = 0
        for i in range(len(transactions)):
            if (i + 1) % 2 == 1 and transactions[i] % 2 == 1:
                count += 1
        return count