class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        n = len(gas)
        total_gas = 0
        current_gas = 0
        start_index = 0

        for i in range(n):
            total_gas += gas[i] - cost[i]
            current_gas += gas[i] - cost[i]

            if current_gas < 0:
                start_index = i + 1
                current_gas = 0

        if total_gas < 0:
            return -1
        else:
            return start_index