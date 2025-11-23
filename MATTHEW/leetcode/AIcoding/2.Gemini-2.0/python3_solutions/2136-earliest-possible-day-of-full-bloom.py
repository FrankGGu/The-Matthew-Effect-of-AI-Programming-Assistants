class Solution:
    def earliestFullBloom(self, plantTime: List[int], growTime: List[int]) -> int:
        flowers = sorted(zip(growTime, plantTime), reverse=True)

        bloom_day = 0
        plant_end = 0

        for grow, plant in flowers:
            bloom_day = max(bloom_day, plant_end + plant + grow)
            plant_end += plant

        return bloom_day