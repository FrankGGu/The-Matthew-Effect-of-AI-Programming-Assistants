def maxProfitInventory(inv, orders):
    inv.sort()
    n = len(inv)
    left, right = 0, max(inv)

    def canFulfill(m):
        total = 0
        for x in inv:
            if x < m:
                total += x
            else:
                total += m
            if total >= orders:
                return True
        return total >= orders

    while left < right:
        mid = (left + right + 1) // 2
        if canFulfill(mid):
            left = mid
        else:
            right = mid - 1

    total_profit = 0
    count = 0
    for x in inv:
        if x < left:
            total_profit += x * x
            count += x
        else:
            total_profit += left * left
            count += left
        if count >= orders:
            total_profit -= (count - orders) * (count - orders)
            break

    return total_profit % (10**9 + 7)