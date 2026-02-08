class Solution:
    def maxNumberOfFamilies(self, n: int, reservedSeats: List[List[int]]) -> int:
        reserved = defaultdict(set)
        for row, seat in reservedSeats:
            reserved[row].add(seat)

        count = 2 * n

        for row in reserved:
            can_allocate = 0
            if not (2 in reserved[row] or 3 in reserved[row] or 4 in reserved[row] or 5 in reserved[row]):
                can_allocate += 1
            if not (6 in reserved[row] or 7 in reserved[row] or 8 in reserved[row] or 9 in reserved[row]):
                can_allocate += 1
            if can_allocate == 0 and not (4 in reserved[row] or 5 in reserved[row] or 6 in reserved[row] or 7 in reserved[row]):
                can_allocate = 1

            count -= (2 - can_allocate)

        return count