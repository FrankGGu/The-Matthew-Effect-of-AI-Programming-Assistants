class Solution:
    def minCost(self, colors: str, neededTime: List[int]) -> int:
        total_time = 0
        max_time = neededTime[0]
        sum_time = neededTime[0]

        for i in range(1, len(colors)):
            if colors[i] == colors[i - 1]:
                max_time = max(max_time, neededTime[i])
                sum_time += neededTime[i]
            else:
                total_time += sum_time - max_time
                max_time = neededTime[i]
                sum_time = neededTime[i]

        total_time += sum_time - max_time

        return total_time