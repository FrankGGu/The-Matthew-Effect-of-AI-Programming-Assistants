def shortestImpossibleSequence(rolls, k):
    seen = set(rolls)
    needed = 1
    while needed in seen:
        needed += 1
    return needed