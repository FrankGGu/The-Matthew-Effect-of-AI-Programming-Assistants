def canCompleteCircuit(gas, cost):
    total_gas = total_cost = 0
    current_gas = 0
    start_index = 0

    for i in range(len(gas)):
        total_gas += gas[i]
        total_cost += cost[i]
        current_gas += gas[i] - cost[i]

        if current_gas < 0:
            start_index = i + 1
            current_gas = 0

    return start_index if total_gas >= total_cost else -1