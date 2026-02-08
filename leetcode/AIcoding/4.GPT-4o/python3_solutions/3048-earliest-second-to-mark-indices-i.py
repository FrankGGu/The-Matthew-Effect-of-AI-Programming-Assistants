def earliestFullMark(v: List[int], k: int) -> int:
    n = len(v)
    count = [0] * n
    for second in range(n):
        count[v[second]] += 1
        if count[v[second]] == k:
            return second
    return -1