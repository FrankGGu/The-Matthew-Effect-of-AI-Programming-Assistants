def min_cost_array_permutation(cost):
    cost.sort()
    n = len(cost)
    res = 0
    for i in range(n):
        res += cost[i] * (i + 1)
    return res