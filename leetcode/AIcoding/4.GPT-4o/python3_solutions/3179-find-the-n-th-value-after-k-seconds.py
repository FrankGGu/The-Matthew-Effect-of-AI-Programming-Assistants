def findValueAfterKSeconds(positions: List[int], k: int) -> int:
    n = len(positions)
    positions.sort()
    total_time = 0
    for i in range(n):
        total_time += positions[i] * (i + 1)
        if total_time > k:
            return positions[i] - (total_time - k) // (i + 1)
    return positions[-1] + (k - total_time) // n