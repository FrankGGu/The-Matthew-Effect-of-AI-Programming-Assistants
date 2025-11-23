from typing import List

class Solution:
    def invalidTransactions(self, transactions: List[str]) -> List[str]:
        parsed_transactions = []
        for i, t_str in enumerate(transactions):
            name, time_str, amount_str, city = t_str.split(',')
            time = int(time_str)
            amount = int(amount_str)
            parsed_transactions.append({
                'name': name,
                'time': time,
                'amount': amount,
                'city': city,
                'original_string': t_str,
                'index': i
            })

        invalid_transaction_indices = set()

        for i, t1 in enumerate(parsed_transactions):
            if t1['amount'] > 1000:
                invalid_transaction_indices.add(i)

        n = len(parsed_transactions)
        for i in range(n):
            for j in range(i + 1, n):
                t1 = parsed_transactions[i]
                t2 = parsed_transactions[j]

                if t1['name'] == t2['name'] and \
                   t1['city'] != t2['city'] and \
                   abs(t1['time'] - t2['time']) <= 60:
                    invalid_transaction_indices.add(i)
                    invalid_transaction_indices.add(j)

        result = []
        for idx in invalid_transaction_indices:
            result.append(parsed_transactions[idx]['original_string'])

        return result