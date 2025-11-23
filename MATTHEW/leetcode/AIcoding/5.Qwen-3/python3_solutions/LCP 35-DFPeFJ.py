class Solution:
    def tour(self, gas: List[int], cost: List[int]) -> int:
        n = len(gas)
        total_tank = 0
        current_tank = 0
        start = 0
        for i in range(n):
            total_tank += gas[i] - cost[i]
            current_tank += gas[i] - cost[i]
            if current_tank < 0:
                start = i + 1
                current_tank = 0
        return start if total_tank >= 0 else -1