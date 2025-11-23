class Solution:
    def maximumBags(self, capacity: List[int], rocks: List[int], additionalRocks: int) -> int:
        remaining = [cap - rock for cap, rock in zip(capacity, rocks)]
        remaining.sort()
        full_bags = 0
        for r in remaining:
            if additionalRocks >= r:
                additionalRocks -= r
                full_bags += 1
            else:
                break
        return full_bags