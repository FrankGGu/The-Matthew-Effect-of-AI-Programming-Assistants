from typing import List

class Solution:
    def earliestFullBloom(self, plantTime: List[int], growTime: List[int]) -> int:
        flowers = []
        for i in range(len(plantTime)):
            flowers.append((plantTime[i], growTime[i]))

        flowers.sort(key=lambda x: x[1], reverse=True)

        current_plant_time = 0
        max_bloom_time = 0

        for p_time, g_time in flowers:
            current_plant_time += p_time
            max_bloom_time = max(max_bloom_time, current_plant_time + g_time)

        return max_bloom_time