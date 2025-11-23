from typing import List

class Solution:
    def invalidTransactions(self, transactions: List[str]) -> List[str]:
        n = len(transactions)
        res = []
        for i in range(n):
            parts = transactions[i].split(',')
            name, time, amount, city = parts[0], int(parts[1]), int(parts[2]), parts[3]
            if int(amount) > 1000:
                res.append(transactions[i])
                continue
            found = False
            for j in range(n):
                if i == j:
                    continue
                parts_j = transactions[j].split(',')
                name_j, time_j, amount_j, city_j = parts_j[0], int(parts_j[1]), int(parts_j[2]), parts_j[3]
                if name == name_j and abs(time - time_j) <= 60 and city != city_j:
                    res.append(transactions[i])
                    found = True
                    break
            if not found:
                continue
        return res