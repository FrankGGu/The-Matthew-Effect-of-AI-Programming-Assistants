def maximumSpendings(prices, budget):
    prices.sort()
    total_spent = 0
    for price in prices:
        if total_spent + price <= budget:
            total_spent += price
        else:
            break
    return total_spent