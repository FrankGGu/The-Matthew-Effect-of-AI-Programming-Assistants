class Solution:
    def minTransfers(self, transactions: List[List[int]]) -> int:
        balance = {}
        for transaction in transactions:
            sender = transaction[0]
            receiver = transaction[1]
            amount = transaction[2]
            balance[sender] = balance.get(sender, 0) - amount
            balance[receiver] = balance.get(receiver, 0) + amount

        debts = [val for val in balance.values() if val != 0]

        def min_transfers_helper(debts):
            if not debts:
                return 0

            while debts and debts[0] == 0:
                debts.pop(0)

            if not debts:
                return 0

            res = float('inf')
            for i in range(1, len(debts)):
                if debts[0] * debts[i] < 0:
                    debts[i] += debts[0]
                    res = min(res, 1 + min_transfers_helper(debts[1:]))
                    debts[i] -= debts[0]
            return res

        return min_transfers_helper(debts)