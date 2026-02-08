class Solution:
    def wateringPlants(self, plants: List[int], capacity: int) -> int:
        steps = 0
        current_water = capacity

        for i in range(len(plants)):
            if current_water < plants[i]:
                steps += 2 * i
                current_water = capacity
            current_water -= plants[i]
            steps += 1

        return steps