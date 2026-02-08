def maxNumberOfFamilies(n: int, reservedSeats: List[List[int]]) -> int:
    reserved = {}
    for row, col in reservedSeats:
        if row not in reserved:
            reserved[row] = set()
        reserved[row].add(col)

    total_families = n * 2
    for row in reserved:
        seats = reserved[row]
        if 2 not in seats and 3 not in seats and 4 not in seats and 5 not in seats:
            total_families += 1
        elif 3 not in seats and 4 not in seats:
            total_families += 1
        elif 4 not in seats and 5 not in seats:
            total_families += 1

    return total_families