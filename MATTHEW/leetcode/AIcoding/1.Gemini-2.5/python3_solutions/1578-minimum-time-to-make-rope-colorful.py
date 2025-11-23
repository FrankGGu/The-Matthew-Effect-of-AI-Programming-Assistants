class Solution:
    def minCost(self, colors: str, neededTime: list[int]) -> int:
        n = len(colors)
        if n <= 1:
            return 0

        total_time = 0
        current_max_in_group = neededTime[0] 

        for i in range(1, n):
            if colors[i] == colors[i-1]:
                total_time += min(neededTime[i], current_max_in_group)
                current_max_in_group = max(neededTime[i], current_max_in_group)
            else:
                current_max_in_group = neededTime[i]

        return total_time