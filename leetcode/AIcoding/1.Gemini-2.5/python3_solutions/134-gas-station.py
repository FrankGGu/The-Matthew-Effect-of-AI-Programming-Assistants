class Solution:
    def canCompleteCircuit(self, gas: list[int], cost: list[int]) -> int:
        total_gas_balance = 0
        current_gas_balance = 0
        start_station = 0

        for i in range(len(gas)):
            diff = gas[i] - cost[i]
            total_gas_balance += diff
            current_gas_balance += diff

            if current_gas_balance < 0:
                # If current balance drops below zero, this means we cannot reach
                # station i+1 from any station between start_station and i.
                # So, we must try starting from the next station, i+1.
                start_station = i + 1
                current_gas_balance = 0

        if total_gas_balance >= 0:
            return start_station
        else:
            return -1