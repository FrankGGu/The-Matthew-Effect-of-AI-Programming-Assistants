class Solution:
    def getMinimumTime(self, time: List[int], fruits: List[List[int]], limit: int) -> int:
        total_time = 0
        for fruit in fruits:
            type_i, num_i = fruit
            t = time[type_i]
            batches = (num_i + limit - 1) // limit
            total_time += batches * t
        return total_time