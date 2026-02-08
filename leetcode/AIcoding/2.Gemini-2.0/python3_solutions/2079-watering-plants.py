class Solution:
    def wateringPlants(self, plants: list[int], capacity: int) -> int:
        steps = 0
        current_capacity = capacity
        for i in range(len(plants)):
            if current_capacity >= plants[i]:
                steps += 1
                current_capacity -= plants[i]
            else:
                steps += i
                steps += i + 1
                current_capacity = capacity - plants[i]
        return steps