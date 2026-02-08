class Solution:
    def maxNumberOfFamilies(self, n: int, reservedSeats: List[List[int]]) -> int:
        reserved = {}
        for row, col in reservedSeats:
            if row not in reserved:
                reserved[row] = set()
            reserved[row].add(col)

        count = 0

        for i in range(1, n + 1):
            if i not in reserved:
                count += 2
            else:
                seats = reserved[i]

                can_make = 0

                if 2 not in seats and 3 not in seats and 4 not in seats and 5 not in seats:
                    can_make += 1
                if 6 not in seats and 7 not in seats and 8 not in seats and 9 not in seats:
                    can_make += 1

                if can_make == 0:
                    if 4 not in seats and 5 not in seats and 6 not in seats and 7 not in seats:
                        can_make = 1

                count += can_make

        return count