def invalidTransactions(transactions):
    invalid = set()
    transactions = [t.split(',') for t in transactions]
    for i, (name, time, amount, city) in enumerate(transactions):
        if int(amount) > 1000:
            invalid.add(i)
    for i, (name1, time1, _, city1) in enumerate(transactions):
        for j, (name2, time2, _, city2) in enumerate(transactions):
            if i != j and name1 == name2 and city1 != city2 and abs(int(time1) - int(time2)) <= 60:
                invalid.add(i)
                invalid.add(j)
    return [','.join(transactions[i]) for i in invalid]