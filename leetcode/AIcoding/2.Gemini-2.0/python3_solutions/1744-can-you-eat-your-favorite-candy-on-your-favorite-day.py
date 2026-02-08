from typing import List

class Solution:
    def canEat(self, candiesCount: List[int], queries: List[List[int]]) -> List[bool]:
        prefix_sum = [0] * (len(candiesCount) + 1)
        for i in range(len(candiesCount)):
            prefix_sum[i + 1] = prefix_sum[i] + candiesCount[i]

        result = []
        for type, day, cap in queries:
            min_eat = day + 1
            max_eat = (day + 1) * cap

            available_min = 1 if type == 0 else prefix_sum[type] + 1
            available_max = prefix_sum[type + 1]

            result.append(not (max_eat < available_min or min_eat > available_max))

        return result