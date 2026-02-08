class Solution:
    def wateringPlants(self, plants: list[int], capacityA: int, capacityB: int) -> int:
        n = len(plants)
        left = 0
        right = n - 1

        current_water_A = capacityA
        current_water_B = capacityB

        refills = 0

        while left <= right:
            if left == right:
                # They meet at the same plant.
                # The one with the larger capacity waters this plant.
                # If both have the same capacity, Alice waters.
                if capacityA >= capacityB:
                    if current_water_A < plants[left]:
                        refills += 1
                else: # capacityB > capacityA
                    if current_water_B < plants[right]:
                        refills += 1
                break # Loop terminates after handling the middle plant

            # Alice waters from the left
            if current_water_A < plants[left]:
                refills += 1
                current_water_A = capacityA
            current_water_A -= plants[left]

            # Bob waters from the right
            if current_water_B < plants[right]:
                refills += 1
                current_water_B = capacityB
            current_water_B -= plants[right]

            left += 1
            right -= 1

        return refills