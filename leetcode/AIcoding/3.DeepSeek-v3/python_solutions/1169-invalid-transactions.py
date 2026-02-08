class Solution:
    def invalidTransactions(self, transactions: List[str]) -> List[str]:
        from collections import defaultdict
        trans_dict = defaultdict(list)
        invalid = set()

        for i, trans in enumerate(transactions):
            name, time, amount, city = trans.split(',')
            time = int(time)
            amount = int(amount)
            trans_dict[name].append((time, city, i))
            if amount > 1000:
                invalid.add(i)

        for name in trans_dict:
            trans_list = trans_dict[name]
            trans_list.sort()
            n = len(trans_list)
            for i in range(n):
                time_i, city_i, idx_i = trans_list[i]
                for j in range(i+1, n):
                    time_j, city_j, idx_j = trans_list[j]
                    if time_j - time_i > 60:
                        break
                    if city_i != city_j:
                        invalid.add(idx_i)
                        invalid.add(idx_j)

        return [transactions[i] for i in invalid]