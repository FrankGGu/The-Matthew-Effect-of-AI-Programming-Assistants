class Solution:
    def minCost(self, colors: str, neededTime: list[int]) -> int:
        total_cost = 0
        i = 0
        while i < len(colors) - 1:
            if colors[i] == colors[i + 1]:
                j = i
                max_time = 0
                current_cost = 0
                while j < len(colors) and colors[i] == colors[j]:
                    max_time = max(max_time, neededTime[j])
                    current_cost += neededTime[j]
                    j += 1
                total_cost += current_cost - max_time
                i = j
            else:
                i += 1
        return total_cost