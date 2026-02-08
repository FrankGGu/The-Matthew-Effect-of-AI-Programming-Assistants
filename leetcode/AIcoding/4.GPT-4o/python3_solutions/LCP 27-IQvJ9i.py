def simulateReflection(h: int, w: int, x: int, y: int, d: int) -> List[int]:
    if d == 1:  # moving right
        y = (y - 1 + (h - 1 - x) * 2) % (2 * h) + 1
        x = h if y <= h else 1
    elif d == 2:  # moving left
        y = (y - 1 + x * 2) % (2 * h) + 1
        x = 1 if y <= h else h
    elif d == 3:  # moving down
        x = (x - 1 + (w - 1 - y) * 2) % (2 * w) + 1
        y = w if x <= w else 1
    else:  # moving up
        x = (x - 1 + y * 2) % (2 * w) + 1
        y = 1 if x <= w else w
    return [x, y]