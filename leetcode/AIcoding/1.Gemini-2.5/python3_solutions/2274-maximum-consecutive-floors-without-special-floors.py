import collections

class Solution:
    def maxConsecutive(self, bottom: int, top: int, special: list[int]) -> int:

        # Add virtual special floors at bottom-1 and top+1 to simplify boundary handling
        # This allows treating the segments from bottom to first_special-1 and
        # from last_special+1 to top in the same way as segments between two special floors.
        all_special_floors = [bottom - 1] + special + [top + 1]

        # Sort all special floors including the virtual ones
        all_special_floors.sort()

        max_consecutive_floors = 0

        # Iterate through the sorted special floors to find the maximum gap
        # A gap between two consecutive special floors (s1, s2) represents
        # s2 - s1 - 1 non-special consecutive floors.
        for i in range(len(all_special_floors) - 1):
            floor_diff = all_special_floors[i+1] - all_special_floors[i]
            # The number of consecutive non-special floors is floor_diff - 1
            max_consecutive_floors = max(max_consecutive_floors, floor_diff - 1)

        return max_consecutive_floors