class Solution:
    def mergeTriplets(self, triplets: list[list[int]], target: list[int]) -> bool:
        found_x = False
        found_y = False
        found_z = False

        tx, ty, tz = target

        for x, y, z in triplets:
            if x <= tx and y <= ty and z <= tz:
                if x == tx:
                    found_x = True
                if y == ty:
                    found_y = True
                if z == tz:
                    found_z = True

            if found_x and found_y and found_z:
                return True

        return found_x and found_y and found_z