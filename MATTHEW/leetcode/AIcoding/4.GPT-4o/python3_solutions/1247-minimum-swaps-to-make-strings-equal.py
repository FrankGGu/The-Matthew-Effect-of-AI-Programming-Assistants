def minimumSwap(s1: str, s2: str) -> int:
    if len(s1) != len(s2):
        return -1

    xy, yx = 0, 0
    for a, b in zip(s1, s2):
        if a == 'x' and b == 'y':
            xy += 1
        elif a == 'y' and b == 'x':
            yx += 1

    swaps = xy // 2 + yx // 2
    if xy % 2 + yx % 2 == 1:
        return -1
    return swaps + (xy % 2)