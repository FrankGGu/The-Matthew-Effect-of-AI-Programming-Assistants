def shortestImpossibleSequence(rolls, k):
    seen = set()
    length = 0
    for roll in rolls:
        seen.add(roll)
        if len(seen) == k:
            length += 1
            seen = set()
    return length + 1