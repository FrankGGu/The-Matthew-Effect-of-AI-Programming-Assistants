class Solution:
    def maxNumberOfFamilies(self, n: int, reservedSeats: List[List[int]]) -> int:
        reserved = collections.defaultdict(set)
        for row, seat in reservedSeats:
            reserved[row].add(seat)

        res = 0
        for row in reserved:
            seats = reserved[row]
            count = 0
            if 2 not in seats and 3 not in seats and 4 not in seats and 5 not in seats:
                count += 1
            if 6 not in seats and 7 not in seats and 8 not in seats and 9 not in seats:
                count += 1
            if count == 0 and 4 not in seats and 5 not in seats and 6 not in seats and 7 not in seats:
                count += 1
            res += count

        res += 2 * (n - len(reserved))
        return res