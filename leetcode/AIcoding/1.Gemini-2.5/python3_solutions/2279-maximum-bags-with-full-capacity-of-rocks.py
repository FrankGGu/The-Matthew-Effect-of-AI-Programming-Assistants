class Solution:
    def maximumBags(self, capacity: list[int], rocks: list[int], additionalRocks: int) -> int:
        n = len(capacity)
        needed_rocks = []
        for i in range(n):
            needed_rocks.append(capacity[i] - rocks[i])

        needed_rocks.sort()

        full_bags = 0
        for needed in needed_rocks:
            if needed <= additionalRocks:
                additionalRocks -= needed
                full_bags += 1
            else:
                break

        return full_bags