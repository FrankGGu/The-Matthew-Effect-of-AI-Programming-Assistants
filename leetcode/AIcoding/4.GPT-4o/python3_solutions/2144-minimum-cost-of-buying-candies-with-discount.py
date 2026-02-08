def minimumCost(cost):
    cost.sort(reverse=True)
    total_cost = 0
    for i in range(len(cost)):
        if (i % 3) != 2:
            total_cost += cost[i]
    return total_cost