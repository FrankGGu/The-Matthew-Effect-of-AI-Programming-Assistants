class Solution:
    def earliestFullBloom(self, plantTime: List[int], growTime: List[int]) -> int:
        plants = sorted(zip(plantTime, growTime), key=lambda x: -x[1])
        current_day = 0
        max_day = 0

        for p_time, g_time in plants:
            current_day += p_time
            max_day = max(max_day, current_day + g_time)

        return max_day