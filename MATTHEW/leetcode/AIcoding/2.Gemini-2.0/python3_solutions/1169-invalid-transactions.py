class Solution:
    def invalidTransactions(self, transactions: list[str]) -> list[str]:
        transactions_list = []
        for transaction in transactions:
            name, time, amount, city = transaction.split(',')
            transactions_list.append((name, int(time), int(amount), city, transaction))

        invalid = []
        for i, (name1, time1, amount1, city1, transaction1) in enumerate(transactions_list):
            if amount1 > 1000:
                invalid.append(transaction1)
                continue

            for j, (name2, time2, amount2, city2, transaction2) in enumerate(transactions_list):
                if i != j and name1 == name2 and abs(time1 - time2) <= 60 and city1 != city2:
                    invalid.append(transaction1)
                    break

        return list(set(invalid))