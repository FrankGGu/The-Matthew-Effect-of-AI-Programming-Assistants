class Solution:
    def wateringPlants(self, plants: list[int], capacity: int) -> int:
        steps = 0
        current_water = capacity

        for i in range(len(plants)):
            # Always walk 1 step to the current plant from the previous one (or river for i=0).
            # This accounts for the movement from position (i-1) to (i).
            steps += 1 

            # Check if current water is sufficient for the current plant
            if current_water < plants[i]:
                # If not enough water, a refill is needed.
                # 1. Walk back to the river (position -1) from the current plant (position i).
                #    The problem's example implies this distance is 'i' steps.
                steps += i

                # 2. Refill the watering can to its full capacity.
                current_water = capacity

                # 3. Walk from the river (position -1) back to the current plant (position i).
                #    The problem's example implies this distance is 'i + 1' steps.
                steps += (i + 1)

            # Water the current plant.
            current_water -= plants[i]

        return steps