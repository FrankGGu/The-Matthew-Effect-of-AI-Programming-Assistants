class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        n = len(gas)
        total_tank = 0
        curr_tank = 0
        start_station = 0
        for i in range(n):
            total_tank += gas[i] - cost[i]
            curr_tank += gas[i] - cost[i]
            if curr_tank < 0:
                start_station = i + 1
                curr_tank = 0
        if total_tank >= 0:
            return start_station
        else:
            return -1