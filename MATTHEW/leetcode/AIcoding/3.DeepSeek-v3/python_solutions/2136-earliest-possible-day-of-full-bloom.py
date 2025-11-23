class Solution:
    def earliestFullBloom(self, plantTime: List[int], growTime: List[int]) -> int:
        indices = sorted(range(len(growTime)), key=lambda i: -growTime[i])
        current_plant_time = 0
        max_bloom_time = 0
        for i in indices:
            current_plant_time += plantTime[i]
            max_bloom_time = max(max_bloom_time, current_plant_time + growTime[i])
        return max_bloom_time