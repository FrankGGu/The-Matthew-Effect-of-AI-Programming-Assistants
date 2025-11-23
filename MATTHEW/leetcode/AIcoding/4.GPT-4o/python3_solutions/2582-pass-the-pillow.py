def passThePillow(n: int, time: int) -> int:
    position = time % (2 * (n - 1))
    return position if position < n else (2 * (n - 1) - position)