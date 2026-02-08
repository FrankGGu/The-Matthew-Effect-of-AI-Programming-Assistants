import collections

class Solution:
    def maxNumberOfFamilies(self, n: int, reservedSeats: list[list[int]]) -> int:
        row_reservations = collections.defaultdict(set)
        for r, c in reservedSeats:
            row_reservations[r].add(c)

        total_families = (n - len(row_reservations)) * 2

        for reserved_cols_in_r in row_reservations.values():
            # Check for two disjoint groups: (2,3,4,5) and (6,7,8,9)
            can_place_left_group = True
            for c in [2, 3, 4, 5]:
                if c in reserved_cols_in_r:
                    can_place_left_group = False
                    break

            can_place_right_group = True
            for c in [6, 7, 8, 9]:
                if c in reserved_cols_in_r:
                    can_place_right_group = False
                    break

            if can_place_left_group and can_place_right_group:
                total_families += 2
            elif can_place_left_group or can_place_right_group:
                total_families += 1
            else:
                # If neither disjoint group is fully available, check the middle group (4,5,6,7)
                can_place_middle_group = True
                for c in [4, 5, 6, 7]:
                    if c in reserved_cols_in_r:
                        can_place_middle_group = False
                        break
                if can_place_middle_group:
                    total_families += 1

        return total_families