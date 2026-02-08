def minBoxes(n: int) -> int:
    left = n
    boxes = 0
    k = 0

    while left > 0:
        k += 1
        left -= k
        boxes += 1

        if left < 0:
            boxes += 1
            break

    return boxes